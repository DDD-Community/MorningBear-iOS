//
//  MyPageSettingViewController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift

import MorningBearUI

class MyPageSettingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

private extension MyPageSettingViewController {
    enum MyPageSettingSection: Hashable, CaseIterable {
        case profile
        case divider
        case settings
    }
    
    var collectionViewBuilder: CollectionViewBuilder<MyPageSettingSection, AnyHashable> {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 20
        
        return .init(
            base: self.collectionView,
            sections: [],
            cellTypes: [ProfileCell.self, CategoryCell.self, DividerCell.self, CapsuleCell.self, RecentMorningCell.self],
            supplementarycellTypes: [.header(HomeSectionHeaderCell.self)],
            cellProvider: { [weak self] collectionView, indexPath, _ in
                guard let self else { return UICollectionViewCell() }
                return UICollectionViewCell()
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                switch elementKind {
                case UICollectionView.elementKindSectionHeader:
//                    return self.properHeaderCell(for: indexPath)
                    return UICollectionReusableView()
                default:
                    return UICollectionReusableView()
                }
            },
            observableProvider: { section in
                return .replace(Observable.of([""]))
                
                //                switch section {
                //                case .state:
                //                    return .replace(Observable.of([self.viewModel.profile]))
                //                case .category:
                //                    return .replace(Observable.of([self.viewModel.category]))
                //                case .divider:
                //                case .themeSelection:
                //                    return .replace(Observable.of(self.viewModel.themes))
                //                case .myMorning:
                //                    return .replace(Observable.of(self.viewModel.recentMorning))
                //                }
            },
            layoutSectionProvider: { section, _ in
                let provider = CompositionalLayoutProvider()
                
                return provider.divier()
            },
            layoutConfiguration: layoutConfig,
            delegate: self,
            disposeBag: bag
        )
    }
}

extension MyPageSettingViewController: UICollectionViewDelegate {}
