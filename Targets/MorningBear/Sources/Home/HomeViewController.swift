//
//  HomeViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    private var dataSource = Mock.dataSource
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            layoutCollectionView()
            configureCollectionView()
            connectCollectionView()
            registerCells()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // FIXME: 색깔 이거 아닌 것 같음
        self.view.backgroundColor = MorningBearAsset.Colors.gray100.color
    }
}

// MARK: - Collection view setting tools
extension HomeViewController {
    private func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch self.dataSource[section] {
            case .state:
                return provider.plainLayoutSection(height: 200) // 1개 셀
            case .recentMornings:
                return provider.staticGridLayoutSection(column: 2)
            case .badges:
                return provider.horizontalScrollLayoutSection(column: 2)
            case .articles:
                let section = provider.horizontalScrollLayoutSection(column: 1)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        
        layout.configuration = config
        collectionView.collectionViewLayout = layout
    }
    
    private func configureCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
    }
    
    private func connectCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCells() {
        // 나의 최근 미라클 모닝
        var cellNib = UINib(nibName: "RecentMorningCell", bundle: nil)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "RecentMorningCell")
        
        cellNib = UINib(nibName: "StateCell", bundle: nil)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "StateCell")
        
        // 배지
        cellNib = UINib(nibName: "BadgeCell", bundle: nil)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "BadgeCell")
        
        // 아티클
        cellNib = UINib(nibName: "ArticleCell", bundle: nil)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "ArticleCell")
        
        // 헤더 - 공용
        cellNib = UINib(nibName: "HomeSectionHeaderCell", bundle: nil)
        collectionView.register(cellNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeSectionHeaderCell")
        
        // 푸터 - 공용
        cellNib = UINib(nibName: "HomeSectionFooterCell", bundle: nil)
        collectionView.register(cellNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "HomeSectionFooterCell")
    }
}

// MARK: - Delegate methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        800
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .state:
            return 1
        case let .recentMornings(states):
            return min(4, states.count) // 고정값(최근 미라클 모닝은 상위 4개만 표시)
        case let .badges(badges):
            return badges.count
        case let .articles(articles):
            return articles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.dataSource[indexPath.section] {
        case let .state(state):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "StateCell", for: indexPath
            ) as! StateCell
            
            let item = state
            cell.prepare(state: item)
            
            return cell
            
        case let .recentMornings(mornings):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "RecentMorningCell", for: indexPath
            ) as! RecentMorningCell
            
            let item = mornings.prefix(4)[indexPath.item] // 최근 미라클 모닝은 상위 4개만 표시; MARK: 정렬 필수
            cell.prepare(image: item.image, titleText: item.title)
            
            return cell
            
        case let .badges(badges):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "BadgeCell", for: indexPath
            ) as! BadgeCell
            
            let item = badges[indexPath.item]
            cell.prepare(badge: item)
            
            return cell
            
        case let .articles(articles):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ArticleCell", for: indexPath
            ) as! ArticleCell
            
            let item = articles[indexPath.item]
            cell.prepare(article: item)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 헤더 & 푸터 설정
        switch kind {
            // Header case
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
        switch dataSource[indexPath.section] {
        case .recentMornings:
            headerCell.prepare(descText: nil, titleText: "나의 최근 미라클모닝", needsButton: false)
        case .badges:
            headerCell.prepare(descText: "모두 보기>", titleText: "내가 모은 배지", needsButton: true)
        case .articles:
            headerCell.prepare(descText: "모두 보기>", titleText: "읽을거리", needsButton: true)
        default:
            headerCell.prepare(descText: "모두 보기>", titleText: "나의 최근 미라클모닝", needsButton: true)
        }
        
        return headerCell
    }

    /// 섹션 별로 적절한 푸터 뷰를 제공
    ///
    /// 현재로서는 차이가 없음
    private func properFooterCell(for indexPath: IndexPath) -> HomeSectionFooterCell {
        let footerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "HomeSectionFooterCell",
            for: indexPath
        ) as! HomeSectionFooterCell
        
        footerCell.prepare(buttonText: "더 보러가기")
        
        return footerCell
    }
}
