//
//  MyPageViewController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/30.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import MorningBearUI

class MyPageViewController: UIViewController {
    private let bag = DisposeBag()

    typealias DiffableDataSource = UICollectionViewDiffableDataSource<MyPageSection, AnyHashable>
    var diffableDataSource: DiffableDataSource!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set design
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        designNavigationBar()
    }
    
    enum MyPageSection: Int, Hashable {
        case state
        case category
        case myMorning
    }
}

private extension MyPageViewController {
    func designNavigationBar() {
        // Configure bar items
        self.navigationItem.leftBarButtonItem = MorningBearBarButtonItem.textButton("마이페이지")
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.hidesSearchBarWhenScrolling = true
        
        let settingButton = MorningBearBarButtonItem.settingButton
        self.navigationItem.rightBarButtonItems = [settingButton]
        
        // Bind buttons
        settingButton.rx.tap.bind { _ in
            print("tapped")
        }
        .disposed(by: bag)
    }
}

extension MyPageViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            
            switch MyPageSection(rawValue: section) {
            case .state:
                return provider.plainLayoutSection(height: 100)
            case .category:
                return provider.plainLayoutSection(height: 154)
            case .myMorning:
                return provider.squareCellDynamicGridLayoutSection(column: 3)
            default:
                fatalError("가질 수 없는 섹션 인덱스")
            }
        }
    }
    
    func designCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
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
        
        // 카테고리
//        cellNib = UINib(nibName: "BadgeCell", bundle: bundle)
//        collectionView.register(cellNib,
//                                forCellWithReuseIdentifier: "BadgeCell")
        
        // 나의 최근 미라클 모닝
        cellNib = UINib(nibName: "RecentMorningCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "RecentMorningCell")
    }
}

extension MyPageViewController: DiffableDataSourcing {
    typealias Section = MyPageSection
    typealias Model = AnyHashable
    
    func makeDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource {
        configureDiffableDataSource(with: collectionView) {
            
        }
    }
    
    func bindDataSourceWithObservable(_ dataSource: DataSouce) {
        <#code#>
    }
}

extension MyPageViewController: UICollectionViewDelegate {}
