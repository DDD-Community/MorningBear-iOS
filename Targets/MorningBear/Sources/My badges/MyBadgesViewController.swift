//
//  MyBadgesViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/31.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

class MyBadgesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MyBadgesViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()

        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch MyBadgeSection(rawValue: section) {
            case .state:
                return provider.plainLayoutSection(height: 160, inset: .zero) // 1개 셀
            case .badges:
                return provider.dynamicGridLayoutSection(column: 3)
            case .none:
                return nil
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 6
        
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
        let bundle = MorningBearUIResources.bundle
        // 상태(헤더)
        var cellNib = UINib(nibName: "MyBadgeStateCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "MyBadgeStateCell")
        
        // 배지
        cellNib = UINib(nibName: "BadgeCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "BadgeCell")
    }
}

extension MyBadgesViewController: UICollectionViewDelegate {}

extension MyBadgesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MyBadgeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MyBadgeSection(rawValue: section) {
        case .state:
            return 1 // 헤더기 때문에 하나만 존재
        case .badges:
            return 14
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MyBadgeSection(rawValue: indexPath.section) {
        case .state:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "MyBadgeStateCell", for: indexPath
            ) as! MyBadgeStateCell
            
            
            cell.prepare(MyBadgeState(nickname: "크크크", badgeCount: 12))
            return cell
            
        case .badges:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "BadgeCell", for: indexPath
            ) as! BadgeCell
            
            
            cell.prepare(badge: Badge(image: UIImage(systemName: "person")!, title: "ss", desc: "Ss"))
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
