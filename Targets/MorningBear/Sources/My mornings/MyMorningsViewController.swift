//
//  MyMorningsViewController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearUI

class MyMorningsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.title = "나의 미라클모닝"
    }
}

extension MyMorningsViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        let section = provider.squareCellDynamicGridLayoutSection(column: 2)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = layout
    }
    
    func designCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
    }
    
    func connectCollectionViewWithDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        let bundle = MorningBearUIResources.bundle
        // 상태(헤더)
        var cellNib = UINib(nibName: "HomeSectionHeaderCell", bundle: bundle)
        collectionView.register(cellNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeSectionHeaderCell")
        
        // 나의 모닝
        cellNib = UINib(nibName: "RecentMorningCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "RecentMorningCell")
    }
}

extension MyMorningsViewController: UICollectionViewDelegate {}

extension MyMorningsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15 // 임시
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "RecentMorningCell", for: indexPath
        ) as! RecentMorningCell
        
        cell.prepare(RecentMorning(image: UIColor.random.image(), title: "kkk", desc: "kkk"))
        return cell
    }
    
    // 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return properHeaderCell(for: indexPath)
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Internal tools
extension MyMorningsViewController {
    /// 섹션 별로 적절한 헤더 뷰를 제공
    ///
    /// 현재로서는 버튼 유무만 조정
    private func properHeaderCell(for indexPath: IndexPath) -> HomeSectionHeaderCell {
        let headerCell = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HomeSectionHeaderCell",
            for: indexPath
        ) as! HomeSectionHeaderCell
        
        
        headerCell.prepare(title: "나의 최근 미라클 모닝", buttonText: "정렬 방식") { [weak self] in
            guard let self = self else {
                return
            }
            
            // do something
            print("정렬")
        }
        
        return headerCell
    }
}
