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
    
    private var environmentViewModel: MyPageViewModel!
    private let viewModel = MyPageSettingViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<MyPageSettingSection, AnyHashable>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

        // set collection view
        let (_collectionView, _dataSource) = collectionViewBuilder.build()
        self.collectionView = _collectionView
        self.dataSource = _dataSource
    }
}

extension MyPageSettingViewController {
    func prepare(environmentViewModel: MyPageViewModel) {
        self.environmentViewModel = environmentViewModel
    }
}

private extension MyPageSettingViewController {
    enum MyPageSettingSection: Int, Hashable, CaseIterable {
        case profile
        case divider
        case settings
    }
    
    var collectionViewBuilder: CollectionViewBuilder<MyPageSettingSection, AnyHashable> {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 20
        
        return .init(
            base: self.collectionView,
            sections: [.profile, .divider, .settings],
            cellTypes: [ProfileCell.self, DividerCell.self, SettingListCell.self],
            supplementarycellTypes: [.header(HomeSectionHeaderCell.self)],
            cellProvider: { [weak self] collectionView, indexPath, _ in
                guard let self else { return UICollectionViewCell() }
                
                switch MyPageSettingSection(rawValue: indexPath.section) {
                case .profile:
                    let buttonProfile = self.environmentViewModel.profile.eraseToButtonContext(text: "정보 수정하기", action: { print("수정") })
                    return ProfileCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: buttonProfile)
                case .divider:
                    return DividerCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: ())
                case .settings:
                    return SettingListCell.dequeueAndPrepare(from: collectionView, at: indexPath, sources: self.viewModel.settings)
                case .none:
                    fatalError("가질 수 없는 섹션 인덱스")
                }
            },
            observableProvider: { [weak self] section in
                guard let self else {
                    return .replace(Observable.of([""]))
                }
                
                switch section {
                case .profile:
                    return .replace(Observable.of([self.viewModel.profile]))
                case .divider:
                    return .replace(Observable.of([""])) // Empty single value
                case .settings:
                    return .replace(Observable.of(self.viewModel.settings))
                }
            },
            layoutSectionProvider: { section, _ in
                let provider = CompositionalLayoutProvider()
                
                switch MyPageSettingSection(rawValue: section) {
                case .profile:
                    let layout = provider.plainLayoutSection(height: 100)
                    layout.contentInsets = .init(top: 17, leading: 18, bottom: 0, trailing: 18)
                    
                    return layout
                case .divider:
                    return provider.divier(height: 6)
                case .settings:
                    return provider.verticalScrollLayoutSection(showItemCount: 8)
                case .none:
                    fatalError("가질 수 없는 섹션 인덱스")
                }
            },
            layoutConfiguration: layoutConfig,
            delegate: self,
            disposeBag: bag
        )
    }
}

extension MyPageSettingViewController: UICollectionViewDelegate {}
