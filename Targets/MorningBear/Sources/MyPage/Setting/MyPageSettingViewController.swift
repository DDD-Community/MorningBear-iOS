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
        
        viewModel.logoutCellAction = { [weak self] in
            guard let self else { return }
            
            let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                guard let self else { return }
                self.viewModel.logout()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
            
            self.present(alert, animated: true)
        }
        
        viewModel.withdrawalCellAction = { [weak self] in
            guard let self else { return }
            
            let alert = UIAlertController(title: "탈퇴 하시겠습니까?", message: "탈퇴 후 모든 정보는 삭제됩니다", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                guard let self else { return }
                self.viewModel.withdrawal()
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
            
            self.present(alert, animated: true)
        }
        
        viewModel.supportCellAction = {
            let supportLink = URL(string: "https://forms.gle/eoXn3AuqKrSqitJU8")!
            UIApplication.shared.open(supportLink)
        }
    }
}

extension MyPageSettingViewController {
    func prepare(environmentViewModel: MyPageViewModel) {
        self.environmentViewModel = environmentViewModel
    }
}

private extension MyPageSettingViewController {
    enum MyPageSettingSection: Int, Hashable, CaseIterable {
//        case profile
//        case divider
        case settings
    }
    
    var collectionViewBuilder: CollectionViewBuilder<MyPageSettingSection, AnyHashable> {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfig.interSectionSpacing = 20
        
        return .init(
            base: self.collectionView,
            sections: [.settings], //[.profile, .divider, .settings],
            cellTypes: [ProfileCell.self, DividerCell.self, SettingListCell.self],
            supplementarycellTypes: [.header(HomeSectionHeaderCell.self)],
            cellProvider: { [weak self] collectionView, indexPath, _ in
                guard let self else { return UICollectionViewCell() }
                
                switch MyPageSettingSection(rawValue: indexPath.section) {
//                case .profile:
//                    let buttonProfile = self.environmentViewModel.profile.eraseToButtonContext(text: "정보 수정하기", action: {
//                        let storyboard = UIStoryboard(name: "InitialInfo", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "SetProfile") as! SetProfileViewController
//
//                        vc.viewModel = InitialInfoViewModel()
//                        self.show(vc, sender: self)
//                    })
//
//                    return ProfileCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: buttonProfile)
//                case .divider:
//                    return DividerCell.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: ())
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
//                case .profile:
//                    return .replace(Observable.of([self.viewModel.profile]))
//                case .divider:
//                    return .replace(Observable.of([""])) // Empty single value
                case .settings:
                    return .replace(Observable.of(self.viewModel.settings))
                }
            },
            layoutSectionProvider: { section, _ in
                let provider = CompositionalLayoutProvider()
                
                switch MyPageSettingSection(rawValue: section) {
//                case .profile:
//                    let layout = provider.plainLayoutSection(height: 100)
//                    layout.contentInsets = .init(top: 17, leading: 18, bottom: 0, trailing: 18)
//
//                    return layout
//                case .divider:
//                    return provider.divier(height: 6)
                case .settings:
                    return provider.verticalScrollLayoutSection(showItemCount: 10)
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
