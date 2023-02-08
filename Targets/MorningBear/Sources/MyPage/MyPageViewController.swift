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
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<MyPageSection, AnyHashable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set collection view
        let (_collectionView, _dataSource) = collectionViewBuilder.build()
        self.collectionView = _collectionView
        self.dataSource = _dataSource
        
        // Set design
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        designNavigationBar()
    }
    
    private var collectionViewBuilder: CollectionViewBuilder<MyPageSection, AnyHashable> {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 20
        
        return .init(
            base: self.collectionView,
            sections: [.state, .category, .divider, .themeSelection, .myMorning],
            cellTypes: [ProfileCell.self, CategoryCell.self, DividerCell.self, CapsuleCell.self, RecentMorningCell.self],
            supplementarycellTypes: [.header(HomeSectionHeaderCell.self)],
            cellProvider: { [weak self] collectionView, indexPath, _ in
                guard let self else { return UICollectionViewCell() }

                switch MyPageSection(rawValue: indexPath.section) {
                case .state:
                    return ProfileCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.profile)
                case .category:
                    return CategoryCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: self.viewModel.category)
                case .divider:
                    return DividerCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: ())
                case .themeSelection:
                    return CapsuleCell.dequeueAndPrepare(from: collectionView, at: indexPath, sources: self.viewModel.themes)
                case .myMorning:
                    return RecentMorningCell.dequeueAndPrepare(from: collectionView, at: indexPath, sources: self.viewModel.recentMorning)
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
            observableProvider: { section in
                switch section {
                case .state:
                    return .replace(Observable.of([self.viewModel.profile]))
                case .category:
                    return .replace(Observable.of([self.viewModel.category]))
                case .divider:
                    return .replace(Observable.of([""]))
                case .themeSelection:
                    return .replace(Observable.of(self.viewModel.themes))
                case .myMorning:
                    return .replace(Observable.of(self.viewModel.recentMorning))
                }
            },
            layoutSectionProvider: { section, _ in
                let provider = CompositionalLayoutProvider()
                
                switch MyPageSection(rawValue: section) {
                case .state:
                    let layout = provider.plainLayoutSection(height: 100)
                    layout.contentInsets = .init(top: 17, leading: 18, bottom: 0, trailing: 18)
                    
                    return layout
                case .category:
                    let layout = provider.horizontalScrollLayoutSectionWithHeader(showItemCount: 4, height: 71)
                    layout.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
                    
                    return layout
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
            
            self.navigationController?.pushViewController(settingViewController, animated: true)
        }
        .disposed(by: bag)
    }
}

private extension MyPageViewController {
    enum MyPageSection: Int, Hashable, CaseIterable {
        case state
        case category
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

        headerCell.prepare(title: "나의 미라클모닝 목록")
        return headerCell
    }
}

extension MyPageViewController: UICollectionViewDelegate {}
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
