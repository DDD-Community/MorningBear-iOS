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
        let layout = UICollectionViewCompositionalLayout(section: provider.dynamicGridLayoutSection(column: 3))

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
        // 배지
        let bundle = MorningBearUIResources.bundle
        let cellNib = UINib(nibName: "BadgeCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "BadgeCell")
    }
}

extension MyBadgesViewController: UICollectionViewDelegate {}

extension MyBadgesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BadgeCell", for: indexPath
        ) as! BadgeCell
        
        
        cell.prepare(badge: Badge(image: UIImage(systemName: "person")!, title: "ss", desc: "Ss"))
        
        return cell
    }
}
