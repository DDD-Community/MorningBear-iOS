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

class HomeViewController: UIViewController, DiffableDataSourcing {
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<HomeSection, AnyHashable>
    var diffableDataSource: DiffableDataSource!
    
    private let bag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    private let refreshControl = UIRefreshControl()
    
    /// 카메라 뷰: 미리 로딩하기 위해서 처음부터 만들어 놓기
    private let cameraViewController = UIImagePickerController()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.refreshControl = self.refreshControl
            // CollectionViewCompositionable 제공함수. 관련 내용 소스파일 or 주석 참조.
            configureCompositionalCollectionView()
        }
    }
    @IBOutlet weak var registerButton: LargeButton! {
        didSet {
            registerButton.setTitle("미라클 모닝 하기", for: .normal)
            registerButton.layer.dropShadow(.standard)
        }
    }
    /// 미라클 모닝 진행중이면 튀어나옴
    @IBOutlet weak var recordingNowButton: RecordingNowButton! {
        didSet {
            recordingNowButton.layer.dropShadow(.standard)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set data source
        diffableDataSource = makeDiffableDataSource(with: collectionView)
        diffableDataSource.initDataSource(allSection: HomeSection.allCases)
        commit(diffableDataSource)
        
        // Set design
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        designNavigationBar()
        
        // Set observables
        bindButtons()
        bindBehaviorAccordingToRecordStatus()
        bindRefreshControl()
    }
}

extension HomeViewController {
    typealias Section = HomeSection
    typealias Model = AnyHashable

    func makeDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource {
        let dataSource = configureDiffableDataSource(with: collectionView) { [weak self] collectionView, indexPath, model in
            guard let self else { return UICollectionViewCell() }
            
            switch HomeSection.getSection(index: indexPath.section) {
            case .state:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "StateCell", for: indexPath
                ) as! StateCell
                
                let state = State(nickname: "만지몬", oneLiner: "갓생사는 하루 되기!")
                let myInfo = self.viewModel.myInfo
                
                cell.prepare(state: state, myInfo: myInfo) {
                    
                }
                
                return cell
                
            case .recentMornings:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "RecentMorningCell", for: indexPath
                ) as! RecentMorningCell
                
                if !self.viewModel.recentMornings.isEmpty {
                    let item = self.viewModel.recentMornings[indexPath.item]
                    cell.prepare(item)
                }
                
                return cell
                
            case .badges:
                return BadgeCell.dequeueAndPrepare(
                    from: collectionView,
                    at: indexPath,
                    prepare: self.viewModel.badges[indexPath.item]
                )
                
            case .articles:
                return ArticleCell.dequeueAndPrepare(
                    from: collectionView,
                    at: indexPath,
                    prepare: self.viewModel.articles[indexPath.item]
                )
            case .none:
                return UICollectionViewCell()
            }
        }
        
        return dataSource
    }
    
    func bindDataSourceWithObservable(_ dataSource: DiffableDataSource) {
        viewModel.$myInfo
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .asDriver(onErrorJustReturn: MyInfo(estimatedTime: 0, totalCount: 0, badgeCount: 0))
            .drive { [weak self] info in
                guard let self else { return }
                
                self.diffableDataSource.replaceDataSource(in: .state, to: [info])
            }
            .disposed(by: bag)
        
        viewModel.$articles
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] articles in
                guard let self else { return }
                
                self.diffableDataSource.replaceDataSource(in: .articles, to: articles)
            }
            .disposed(by: bag)
        
        viewModel.$badges
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] badges in
                guard let self else { return }
                
                self.diffableDataSource.replaceDataSource(in: .badges, to: badges)
            }
            .disposed(by: bag)
        
        viewModel.$recentMornings
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] mornings in
                guard let self else { return }
                
                self.diffableDataSource.replaceDataSource(in: .recentMornings, to: mornings)
            }
            .disposed(by: bag)
    }
    
    func addSupplementaryView(_ diffableDataSource: DiffableDataSource) {
        diffableDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return self.properHeaderCell(for: indexPath)
            case UICollectionView.elementKindSectionFooter:
                return self.properFooterCell(for: indexPath)
            default:
                return UICollectionReusableView()
            }
        }
    }
}

// MARK: - Configure design components
private extension HomeViewController {
    func designNavigationBar() {
        // Configure bar items
        self.navigationItem.leftBarButtonItem = MorningBearBarButtonItem.titleButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        // TODO: 나중에 알람 추가되면 그때 
//        let alarmButton = MorningBearBarButtonItem.notificationButton
//        self.navigationItem.rightBarButtonItems = [alarmButton]
        
        // Bind buttons
//        alarmButton.rx.tap.bind { _ in
//            print("tapped")
//        }
//        .disposed(by: bag)
    }
    
    /// 기록 상태에 따라 달라지는 뷰 행동의 정의
    func bindBehaviorAccordingToRecordStatus() {
        viewModel.recordingStateObservable.withUnretained(self)
            .bind { weakSelf, state in
                switch state {
                case .recording:
                    weakSelf.showRecordingNowButton()
                case .stop:
                    weakSelf.showStartRecordingButton()
                case .waiting:
                    weakSelf.showStartRecordingButton()
                }
            }
            .disposed(by: bag)

        viewModel.elapsedTimeObservable
            .bind(to: recordingNowButton.timeLabel.rx.text)
            .disposed(by: bag)
    }
    
    func bindButtons() {
        registerButton.rx.tap.withUnretained(self)
            .bind { weakSelf, _ in
                switch weakSelf.viewModel.isMyMorningRecording {
                case .recording:
                    // TODO: 좀 더 마일드한 오류를 줄 수도..
                    fatalError("녹화 버튼은 이 조건을 가져서는 안 됨")
                case .stop:
                    weakSelf.startRecording()
                case .waiting:
                    weakSelf.startRecording()
                }
            }
            .disposed(by: bag)
        
        recordingNowButton.stopButton.rx.tap.withUnretained(self)
            .bind { weakSelf, _ in
                switch weakSelf.viewModel.isMyMorningRecording {
                case .recording:
                    weakSelf.stopRecording()
                case .stop:
                    fatalError("중지 버튼은 이 조건을 가져서는 안 됨")
                case .waiting:
                    fatalError("중지 버튼은 이 조건을 가져서는 안 됨")
                }
            }
            .disposed(by: bag)
    }
    
    func bindRefreshControl() {
        refreshControl.rx.controlEvent(.valueChanged)
            .withUnretained(self)
            .bind { weakSelf, _ in
                weakSelf.viewModel.fetchRemoteData()
            }
            .disposed(by: bag)
        
        viewModel.$isNetworking
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] flag in
                guard let self else { return }
                
                if flag == false {
                    self.refreshControl.endRefreshing()
                }
            }
            .disposed(by: bag)
    }
    
    // MARK: - Functional methods
    func startRecording() {
        // 버튼 전환
        showRecordingNowButton()
        viewModel.startRecording()
    }
    
    func stopRecording() {
        guard let registerMorningViewController = UIStoryboard(
            name: "RegisterMorning", bundle: nil
        ).instantiateViewController(withIdentifier: "RegisterMorning") as? RegisterMorningViewController
        else {
            fatalError("뷰 컨트롤러를 불러올 수 없음")
        }
        
        do {
            let startDate = try viewModel.stopRecording()
            
            registerMorningViewController.prepare(startTime: startDate, image: nil, popAction: { [weak self] in
                guard let self else { return }
                
                self.viewModel.fetchRemoteData()
            })
            
            registerMorningViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(registerMorningViewController, animated: true)
            
            // 버튼 전환
            showStartRecordingButton()
        } catch let error {
            showAlert(error)
        }
    }
    
    func showRecordingNowButton() {
        self.registerButton.isHidden = true
        self.recordingNowButton.isHidden = false
    }
    
    func showStartRecordingButton() {
        self.registerButton.isHidden = false
        self.recordingNowButton.isHidden = true
    }
}

// MARK: - Collection view setting tools
extension HomeViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch HomeSection.getSection(index: section) {
            case .state:
                let layout = provider.plainLayoutSection(height: 286)
                layout.contentInsets.top += 16
                return layout // 1개 셀
            case .recentMornings:
                return provider.staticGridLayoutSection(column: 2)
            case .badges:
                return provider.horizontalScrollLayoutSection(column: 2)
            case .articles:
                let section = provider.horizontalScrollLayoutSection(column: 1, groupWidthFraction: 0.7)
                section.orthogonalScrollingBehavior = .groupPaging // 페이징 추가함. 변경 가능
                
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0) // 버튼 때문에 아래 패딩 줌
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
    }
    
    func connectCollectionViewWithDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self.diffableDataSource
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
        
        let cellTypes: [any CustomCellType.Type] = [
            ArticleCell.self, BadgeCell.self
        ]
        cellTypes.forEach { $0.register(to: collectionView) }
        
        
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


// MARK: - Set camera delegate
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let takenPhoto = info[.editedImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            guard let registerMorningViewController = UIStoryboard(name: "RegisterMorning", bundle: nil)
                .instantiateViewController(withIdentifier: "RegisterMorning") as? RegisterMorningViewController else {

                fatalError("뷰 컨트롤러를 불러올 수 없음")
            }
            
            if case .recording(startDate: let savedStartDate) = viewModel.isMyMorningRecording {
                do {
                    registerMorningViewController.prepare(startTime: savedStartDate, image: takenPhoto, popAction: {})
                    registerMorningViewController.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(registerMorningViewController, animated: true)
                } catch let error {
                    self.showAlert(error)
                }
            } else {
                // TODO: Error
            }
        }

        cameraViewController.dismiss(animated: true)
    }
}

// MARK: - Delegate methods
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch HomeSection.getSection(index: indexPath.section) {
        case .articles:
            let article = viewModel.articles[indexPath.row]
            article.openURL(context: UIApplication.shared)
        default:
            // TODO: 언젠간..
            break
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
            headerCell.prepare(title: "내가 획득한 배지", buttonText: "모두 보기>") { [weak self] in
                guard let self = self else {
                    return
                }
                
                // 내가 모은 배지 목록으로 이동(네비게이션)
                self.navigate(boardName: "MyBadges", vcId: "MyBadges")
            }
        case .articles:
            headerCell.prepare(title: "지금 읽기 딱 좋은 아티클", buttonText: "모두 보기>") { [weak self] in
                guard let self = self else {
                    return
                }
                
                // 아티클 모두 보기 목록으로 이동(네비게이션)
                self.navigate(boardName: "ArticlesCollection", vcId: "ArticlesCollection")
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
            self.navigate(boardName: "MyMornings", vcId: "MyMornings")
        }
        
        return footerCell
    }
    
    private func navigate(boardName: String, vcId: String) {
        let board = UIStoryboard(name: boardName, bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: vcId)
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
