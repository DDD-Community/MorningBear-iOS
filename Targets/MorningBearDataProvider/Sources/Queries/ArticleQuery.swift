//
//  ArticleDataProvider.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

@_exported import MorningBearData

import MorningBearNetwork
import MorningBearAPI

public struct ArticleQuery: Queryable {
    let size: Int

    public var singleTrait: Single<[Article]> {
        Network.shared.apollo.rx
            .fetch(query: SearchArticleQuery(input: .some(size)))
            .map { data -> [SearchArticleQuery.Data.SearchArticle] in
                let queryResults = data.data?.searchArticle?.compactMap { $0 }
                
                return queryResults ?? []
            }
            .map { queryResults -> [Article] in
                let articles = queryResults.map { $0.toNativeType }
                
                return articles
            }
    }
    
    public init(size: Int) {
        self.size = size
    }
}

fileprivate extension MorningBearAPI.SearchArticleQuery.Data.SearchArticle  {
    var toNativeType: Article {
        var weblink: URL? = nil // self.link가 없으면 URL == nil
        if let link = self.link {
            weblink = URL(string: link)!
        }
        
        return Article(image: UIColor.random.image(),
                       title: self.title ?? "",
                       description: self.description ?? "",
                       weblink: weblink)
    }
}
