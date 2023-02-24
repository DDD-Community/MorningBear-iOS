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
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.refreshControl = self.refreshControl
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<MyPageSection, AnyHashable>!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set collection view
        let (_collectionView, _dataSource) = collectionViewBuilder
            .addRefreshControl(refreshControl, action: { [weak self] in
                guard let self else { return }
                self.viewModel.fetch()
            })
            .build()
        
        self.collectionView = _collectionView
        self.dataSource = _dataSource
        
        // Set little padding at the bottm
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
    
        // Set design
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        designNavigationBar()
        
        // Bind network flag
        viewModel.$isNetworking.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                guard let self else { return }
                
                if value == false {
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: bag)
    }
    
    private var collectionViewBuilder: CollectionViewBuilder<MyPageSection, AnyHashable> {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 20
        
        return .init(
            base: self.collectionView,
            sections: [.state, .divider, .themeSelection, .myMorning],  //[.state, .category, .divider, .themeSelection, .myMorning],
            cellTypes: [ProfileCell.self, CategoryCell.self, DividerCell.self, CapsuleCell.self, RecentMorningCell.self],
            supplementarycellTypes: [.header(HomeSectionHeaderCell.self)],
            cellProvider: { [weak self] collectionView, indexPath, model in
                guard let self else { return UICollectionViewCell() }

                switch MyPageSection(rawValue: indexPath.section) {
                case .state:
                    return ProfileCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.profile)
//                case .category:
//                    return CategoryCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: model as! MorningBearData.Category)
                case .divider:
                    return DividerCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: ())
                case .themeSelection:
                    return CapsuleCell.dequeueAndPrepare(from: collectionView, at: indexPath, sources: self.viewModel.categoryOptions)
                case .myMorning:
                    return RecentMorningCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: model as! MyMorning)
                case .none:
                    fatalError("가질 수 없는 섹션 인덱스")
                }
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                switch elementKind {
                case UICollectionView.elementKindSectionHeader:
                    return self.properHeaderCell(for: indexPath)
                default:
                    return UICollectionReusableView()
                }
            },
            observableProvider: { [weak self] section in
                guard let self else { return .replace(Observable.of([])) }
                
                switch section {
                case .state:
                    return .replace(self.viewModel.$profile.map{ [$0.eraseToAnyHasable] })
//                case .category:
//                    return .replace(self.viewModel.$categories.map{ $0.eraseToAnyHasable })
                case .divider:
                    return .replace(Observable.of([""]))
                case .themeSelection:
                    return .replace(Observable.of(self.viewModel.categoryOptions))
                case .myMorning:
                    return .replace(self.viewModel.$recentMorning.map{ $0.eraseToAnyHasable })
                }
            },
            layoutSectionProvider: { section, _ in
                let provider = CompositionalLayoutProvider()
                
                switch MyPageSection(rawValue: section) {
                case .state:
                    let layout = provider.plainLayoutSection(height: 100)
                    layout.contentInsets = .init(top: 17, leading: 18, bottom: 0, trailing: 18)
                    
                    return layout
//                case .category:
//                    let option = CompositionalHorizontalLayoutOption(showCount: 6, height: 85)
//                    let subviewOption = CompositionalLayoutSubviewOption(backgroundColor: .white, headerHeight: 70)
//
//                    let layout = provider.horizontalLayoutSection(option: option, subviewOption: subviewOption)
//                    layout.contentInsets = .init(top: 0, leading: 18*2, bottom: 20, trailing: 18*2)
//                    layout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//
//                    return layout
                case .divider:
                    return provider.divier(height: 6)
                case .themeSelection:
                    let layout = provider.horizontalScrollLayoutSectionWithHeader(showItemCount: 5, height: 33)
                    layout.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                    
                    return layout
                case .myMorning:
                    return provider.squareCellDynamicGridLayoutSection(column: 3, needsHeader: false, itemSpacing: 9)
                default:
                    fatalError("가질 수 없는 섹션 인덱스")
                }
            },
            layoutConfiguration: layoutConfig,
            delegate: self,
            disposeBag: bag
        )
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
            // FIXME: move somehwere
            guard let settingViewController = UIStoryboard(name: "MyPageSetting", bundle: nil)
                .instantiateViewController(withIdentifier: "MyPageSetting") as? MyPageSettingViewController else {

                fatalError("뷰 컨트롤러를 불러올 수 없음")
            }
            
            settingViewController.hidesBottomBarWhenPushed = true
            settingViewController.prepare(environmentViewModel: self.viewModel)
            self.navigationController?.pushViewController(settingViewController, animated: true)
        }
        .disposed(by: bag)
    }
}

private extension MyPageViewController {
    enum MyPageSection: Int, Hashable, CaseIterable {
        case state
//        case category
        case divider
        case themeSelection
        case myMorning
    }
    
    func properHeaderCell(for indexPath: IndexPath) -> HomeSectionHeaderCell {
        let headerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeSectionHeaderCell",
            for: indexPath
        ) as! HomeSectionHeaderCell
        
        
        switch MyPageSection(rawValue: indexPath.section) {
//        case .category:
//            headerCell.prepare(title: "카테고리", buttonText: "수정", buttonAction: { [weak self] in
//                guard let self else { return }
//                
//                let storyboard = UIStoryboard(name: "InitialInfo", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "SetActivity") as! SetActivityViewController
//                
//                vc.viewModel = InitialInfoViewModel()
//                self.show(vc, sender: self)
//            })
        case .themeSelection:
            headerCell.prepare(title: "나의 미라클모닝 목록")
        default:
            break
        }

        return headerCell
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if case .themeSelection = MyPageSection(rawValue: indexPath.section) {
            DispatchQueue.main.async {
                guard let category = Category(rawValue: indexPath.row) else {
                    return
                }
                
                self.viewModel.fetchMyMorning(category: category)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > viewModel.recentMorning.count - 6 {
//            viewModel.fetchMyMorning()
        }
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
