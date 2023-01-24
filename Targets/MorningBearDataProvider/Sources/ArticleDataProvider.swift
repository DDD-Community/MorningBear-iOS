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

public struct ArticleDataProvider {
    public func articles() -> [Article] {
        let data: [Article] = [
            .init(image: UIColor.random.image(), title: "아티클 제목", description: "아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
        ]
        
        return data
    }
    
    public init() {}
}

extension ArticleDataProvider: DataProviding {
    public func fetch(_ query: Queries) -> Single<[Article]> {
        guard case .article(let size) = query else {
            return .error(DataProviderError.invalidInput)
        }
        
        return fetch(ArticleQuery(size: size))
    }
    
    public func fetch(_ model: ArticleQuery) -> Single<[Article]> {
        let singleTrait = Network.shared.apollo.rx
            .fetch(query: SearchArticleQuery(input: .some(model.size)))
            .map { data -> [SearchArticleQuery.Data.SearchArticle] in
                let queryResults = data.data?.searchArticle?.compactMap { $0 }
                
                return queryResults ?? []
            }
            .map { queryResults -> [Article] in
                let articles = queryResults.map { $0.toNativeType }
                
                return articles
            }
        
        return singleTrait
    }
    
    /// 사용 편의를 위해 만든 `enum` 없어도 프로토콜은 준수할 수 있음
    public enum Queries {
        case article(size: Int)
    }
    
    public struct ArticleQuery: Queryable {
        let size: Int
    }
}

extension MorningBearAPI.SearchArticleQuery.Data.SearchArticle  {
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
