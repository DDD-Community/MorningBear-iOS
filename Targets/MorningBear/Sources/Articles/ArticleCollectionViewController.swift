//
//  ArticleCollectionViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearUI

class ArticleCollectionViewController: UIViewController {
    private let viewModel = ArticleCollectionViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designNavigationBar()
    }
}

// MARK: - Internal tools
private extension ArticleCollectionViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
}

extension ArticleCollectionViewController: CollectionViewCompositionable {
    func layoutCollectionView() {
        let provider = CompositionalLayoutProvider()
        let section = provider.verticalScrollLayoutSection(showItemCount: 4)
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: section)
    }
    
    func designCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
    }
    
    func connectCollectionViewWithDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCells() {
        let bundle = MorningBearUIResources.bundle
        // 상태(헤더)
        let cellNib = UINib(nibName: "ArticleCell", bundle: bundle)
        collectionView.register(cellNib,
                                forCellWithReuseIdentifier: "ArticleCell")
    }
}

extension ArticleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ArticleCell", for: indexPath
        ) as! ArticleCell
        
        let article = viewModel.articles[indexPath.row]
        cell.prepare(article: article)
        return cell
    }
}
