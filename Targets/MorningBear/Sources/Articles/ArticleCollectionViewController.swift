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
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<ArticleSection, Article>
    
    private let viewModel = ArticleCollectionViewModel()
    var diffableDataSource: DiffableDataSource!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            configureCompositionalCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designNavigationBar()
        
        diffableDataSource = configureDiffableDataSource(with: collectionView)
        diffableDataSource.updateDataSource(in: .main, with: viewModel.articles)
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
        
        collectionView.dataSource = diffableDataSource
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

extension ArticleCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > viewModel.articles.count - 3 {
            let newArticles = viewModel.fetchArticles()
            diffableDataSource.updateDataSource(in: .main, with: newArticles)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]

        article.openURL(context: UIApplication.shared)
    }
}

extension ArticleCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        updateDataSource()
    }
}

// MARK: - Related to diffable datasource
extension ArticleCollectionViewController: DiffableDataSourcing {
    func configureDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource {
        let dataSource = makeDiffableDataSource(with: collectionView) { [weak self] collectionView, indexPath, model in
            guard let self else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ArticleCell", for: indexPath
            ) as! ArticleCell
            
            let article = self.viewModel.articles[indexPath.row]
            cell.prepare(article: article)
            return cell
        }
        
        return dataSource
    }
    
    enum ArticleSection {
        case main
    }
}
