//
//  ArticleCollcetionViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import MorningBearDataProvider

class ArticleCollectionViewModel {
    private let dataProvider: ArticleDataProvider
    
    private(set) var articles = [Article]()
    
    func fetchArticle() -> Observable<[Article]> {
        return dataProvider.fetch(.article(size: 10))
            .do(onSuccess: {[weak self] newArticles in
                guard let self else { return }
                
                self.articles.append(contentsOf: newArticles)
            })
            .asObservable()
    }
    
    init(_ dataProvider: ArticleDataProvider = ArticleDataProvider()) {
        self.dataProvider = dataProvider
    }
}
