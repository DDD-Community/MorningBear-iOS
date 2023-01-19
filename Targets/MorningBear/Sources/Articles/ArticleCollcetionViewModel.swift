//
//  ArticleCollcetionViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import MorningBearUI

class ArticleCollectionViewModel {
    private let dataProvider: ArticleDataProvider
    
    var articles: [Article]
    
    func fetchArticles() -> [Article] {
        let newArticles = dataProvider.articles()
        articles.append(contentsOf: newArticles)
        
        return newArticles
    }
    
    init(_ dataProvider: ArticleDataProvider = ArticleDataProvider()) {
        self.dataProvider = dataProvider
        
        self.articles = dataProvider.articles()
    }
}
