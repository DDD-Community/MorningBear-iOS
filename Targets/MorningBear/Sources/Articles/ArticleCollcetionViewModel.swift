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

class ArticleCollectionViewModel<Provider: DataProviding> {
    private let dataProvider: Provider
    private(set) var articles = [Article]()
    
    func fetchArticle() -> Observable<[Article]> {
        return dataProvider.fetch(ArticleQuery(size: 10))
            .do(onSuccess: {[weak self] newArticles in
                guard let self else { return }
                
                self.articles.append(contentsOf: newArticles)
            })
            .asObservable()
    }
    
    init(_ dataProvider: Provider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
    }
}
