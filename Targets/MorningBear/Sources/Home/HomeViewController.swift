//
//  HomeViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let bag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    // 카메라 뷰: 미리 로딩하기 위해서 처음부터 만들어 놓기
    private let cameraViewController = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            // CollectionViewCompositionable 제공함수. 관련 내용 소스파일 or 주석 참조.
            configureCompositionalCollectionView()
        }
    }
    @IBOutlet weak var registerButton: LargeButton! {
        didSet {
            registerButton.setTitle("미라클 모닝 하기", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designNavigationBar()
        
        bindButtons()

        // FIXME: 색깔 이거 아닌 것 같음
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
}

// MARK: - Configure design components
private extension HomeViewController {
    func designNavigationBar() {
        // Configure bar items
        self.navigationItem.leftBarButtonItem = MorningBearBarButtonItem.titleButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        let searchButton = MorningBearBarButtonItem.searchButton
        let alarmButton = MorningBearBarButtonItem.notificationButton
        self.navigationItem.rightBarButtonItems = [searchButton, alarmButton]
        
        // Bind buttons
        searchButton.rx.tap.bind { _ in
            print("tapped")
        }
        .disposed(by: bag)
        
        alarmButton.rx.tap.bind { _ in
            print("tapped")
        }
        .disposed(by: bag)
    }
    
    func bindButtons() {
        registerButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            self.cameraViewController.sourceType = .camera
            self.cameraViewController.allowsEditing = true
            self.cameraViewController.delegate = self
            
            self.show(self.cameraViewController, sender: self)
        }
        .disposed(by: bag)
    }
}

// MARK: - Set camera delegate
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraViewController.dismiss(animated: true)
    }
}

// MARK: - Collection view setting tools
extension HomeViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch HomeSection.getSection(index: section) {
            case .state:
                return provider.plainLayoutSection(height: 200) // 1개 셀
            case .recentMornings:
                return provider.staticGridLayoutSection(column: 2)
            case .badges:
                return provider.horizontalScrollLayoutSection(column: 2)
            case .articles:
                let section = provider.horizontalScrollLayoutSection(column: 1)
                section.orthogonalScrollingBehavior = .groupPagingCentered // 페이징 추가함. 변경 가능
                
                return section
            case .none:
                return nil
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        
        layout.configuration = config
        collectionView.collectionViewLayout = layout
    }
    
    func designCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
    }
    
    func connectCollectionViewWithDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        let bundle =  MorningBearUIResources.bundle
        
        // 나의 상태. 횟수, 총 시간 등등 맨위에 들어가는 그거
        var cellNib = UINib(nibName: "StateCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "StateCell")
        
        // 나의 최근 미라클 모닝
        cellNib = UINib(nibName: "RecentMorningCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "RecentMorningCell")
        
        // 배지
        cellNib = UINib(nibName: "BadgeCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "BadgeCell")
        
        // 아티클
        cellNib = UINib(nibName: "ArticleCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "ArticleCell")
        
        // 헤더 - 공용
        cellNib = UINib(nibName: "HomeSectionHeaderCell", bundle: bundle)
        collectionView.register(cellNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeSectionHeaderCell")
        
        // 푸터 - 공용
        cellNib = UINib(nibName: "HomeSectionFooterCell", bundle: bundle)
        collectionView.register(cellNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "HomeSectionFooterCell")
    }
}

// MARK: - Delegate methods
extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeSection.getSection(index: section) {
        case .state:
            return 1 // 내 상태는 단일 셀 섹션임
        case .recentMornings:
            return min(4, viewModel.recentMorningList.count) // 최근 미라클 모닝은 상위 4개만 표시
        case .badges:
            return viewModel.badgeList.count
        case .articles:
            return viewModel.articleList.count
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSection.getSection(index: indexPath.section) {
        case .state:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "StateCell", for: indexPath
            ) as! StateCell
            
            let item = viewModel.state
            cell.prepare(state: item)
            
            return cell
            
        case .recentMornings:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecentMorningCell", for: indexPath
            ) as! RecentMorningCell
            
            let item = viewModel.recentMorningList.prefix(4)[indexPath.item] // 최근 미라클 모닝은 상위 4개만 표시; MARK: 정렬 필수
            cell.prepare(item)
            
            return cell
            
        case .badges:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "BadgeCell", for: indexPath
            ) as! BadgeCell
            
            let item = viewModel.badgeList[indexPath.item]
            cell.prepare(badge: item)
            
            return cell
            
        case .articles:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ArticleCell", for: indexPath
            ) as! ArticleCell
            
            let item = viewModel.articleList[indexPath.item]
            cell.prepare(article: item)
            
            return cell
        
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 헤더 & 푸터 설정
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return properHeaderCell(for: indexPath)
            
        case UICollectionView.elementKindSectionFooter:
            return properFooterCell(for: indexPath)
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Internal tools
extension HomeViewController {
    /// 섹션 별로 적절한 헤더 뷰를 제공
    ///
    /// 현재로서는 버튼 유무만 조정
    private func properHeaderCell(for indexPath: IndexPath) -> HomeSectionHeaderCell {
        let headerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeSectionHeaderCell",
            for: indexPath
        ) as! HomeSectionHeaderCell
        
        // 버튼 유무 조정
        switch HomeSection.getSection(index: indexPath.section) {
        case .recentMornings:
            headerCell.prepare(title: "나의 최근 미라클모닝")
        case .badges:
            headerCell.prepare(title: "내가 모은 배지", buttonText: "모두 보기>") { [weak self] in
                guard let self = self else {
                    return
                }
                
                // 내가 모은 배지 목록으로 이동(네비게이션)
                let myBadgeViewController = UIStoryboard(name: "MyBadges", bundle: nil)
                    .instantiateViewController(withIdentifier: "MyBadges")
                
                self.navigationController?.pushViewController(myBadgeViewController, animated: true)
            }
        case .articles:
            headerCell.prepare(title: "읽을거리", buttonText: "모두 보기>") {
                print("읽을거리")
            }
        default:
            break
        }
        
        return headerCell
    }

    /// 섹션 별로 적절한 푸터 뷰를 제공
    ///
    /// 현재로서는 차이가 없음.
    ///
    /// - warning: `CompositionalLayoutProvider`에서 `footer` 존재유무가 이미 정해져서 전달되므로
    /// 보여줄지 말지에 대한 분기처리가 따로 필요 없음
    private func properFooterCell(for indexPath: IndexPath) -> HomeSectionFooterCell {
        let footerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "HomeSectionFooterCell",
            for: indexPath
        ) as! HomeSectionFooterCell
        
        footerCell.prepare(buttonText: "더 보러가기") {
            // 나의 미라클모닝 목록으로 이동(네비게이션)
            let myRecentMorningController = UIStoryboard(name: "MyMornings", bundle: nil)
                .instantiateViewController(withIdentifier: "MyMornings")
            
            self.navigationController?.pushViewController(myRecentMorningController, animated: true)
        }
        
        return footerCell
    }
}
