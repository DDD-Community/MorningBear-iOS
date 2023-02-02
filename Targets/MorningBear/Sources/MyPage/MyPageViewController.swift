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
    private let viewModel = MyPageViewModel()

    typealias DiffableDataSource = UICollectionViewDiffableDataSource<MyPageSection, AnyHashable>
    var diffableDataSource: DiffableDataSource!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set collection view
        diffableDataSource = makeDiffableDataSource(with: collectionView)
        diffableDataSource.initDataSource(allSection: MyPageSection.allCases)
        commit(diffableDataSource)

        // Set design
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        designNavigationBar()
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
                return provider.plainLayoutSection(height: 154)
            default:
                fatalError("가질 수 없는 섹션 인덱스")
            }
        }
        
        collectionView.collectionViewLayout = layout
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

        let cells: [any CustomCellType.Type] = [
            ProfileCell.self, CategoryCell.self, RecentMorningCell.self
        ]
        
        // Register
        cells.forEach { $0.register(to: collectionView, bundle: bundle) }
    }
}

extension MyPageViewController: DiffableDataSourcing {
    typealias Section = MyPageSection
    typealias Model = AnyHashable
    
    func makeDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource {
        let datasource = configureDiffableDataSource(with: collectionView) { [weak self] collectionView, indexPath, model in
            guard let self else { return UICollectionViewCell() }
            
            switch MyPageSection(rawValue: indexPath.section) {
            case .state:
                return ProfileCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.profile)
            case .category:
                return CategoryCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.category)
            case .myMorning:
                return RecentMorningCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.recentMorning)
            case .none:
                return UICollectionViewCell()
            }
        }
        
        return datasource
    }
    
    func bindDataSourceWithObservable(_ dataSource: DiffableDataSource) {
        dataSource.updateDataSource(in: .state, with: [self.viewModel.profile])
        dataSource.updateDataSource(in: .category, with: [self.viewModel.category])
        dataSource.updateDataSource(in: .myMorning, with: [self.viewModel.recentMorning])
    }
    
    enum MyPageSection: Int, Hashable, CaseIterable {
        case state
        case category
        case myMorning
    }
}

extension MyPageViewController: UICollectionViewDelegate {}
