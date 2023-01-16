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
    private var diffableDatasource: UICollectionViewDiffableDataSource<ArticleSection, Article>!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designNavigationBar()
        updateDataSource(with: viewModel.articles)
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
        
        diffableDatasource = self.diffableDatasource(with: collectionView)
        collectionView.dataSource = self.diffableDatasource
        
        collectionView.prefetchDataSource = self
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row, viewModel.articles.count)
        if indexPath.row > viewModel.articles.count - 3 {
            let newArticles = viewModel.fetchArticles()
            updateDataSource(with: newArticles)
        }
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]

        article.openURL(context: UIApplication.shared)
    }
}

enum ArticleSection {
    case main
}

extension ArticleCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        updateDataSource()
    }
}

private extension ArticleCollectionViewController {
    func diffableDatasource(with collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<ArticleSection, Article> {
        let datasource = UICollectionViewDiffableDataSource<ArticleSection, Article>(collectionView: collectionView)
        { [weak self] collectionView, indexPath, article in
            guard let self else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ArticleCell", for: indexPath
            ) as! ArticleCell
            
            let article = self.viewModel.articles[indexPath.row]
            cell.prepare(article: article)
            
            return cell
        }
        
        return datasource
    }
    
    func updateDataSource(with newArticle: [Article]) {
        var snapshot = diffableDatasource.snapshot()
        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections([.main])
        }
        
        print(snapshot.numberOfItems)
        snapshot.appendItems(newArticle)
        
        DispatchQueue.global(qos: .background).async {
            self.diffableDatasource.apply(snapshot, animatingDifferences: true)
        }
    }
}
