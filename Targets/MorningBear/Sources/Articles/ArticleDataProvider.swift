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

import MorningBearUI
import MorningBearNetwork
import MorningBearAPI

struct ArticleDataProvider {
    func fetch(size: Int = 10) -> Single<[Article]> {
        let singleTrait = Network.shared.apollo.rx
            .fetch(query: SearchArticleQuery(input: GraphQLNullable<Int>(integerLiteral: size)))
            .map { data -> [SearchArticleQuery.Data.SearchArticle] in
                let queryResults = data.data?.searchArticle?.compactMap { $0 }
                print(data)
                
                return queryResults ?? []
            }
            .map { queryResults -> [Article] in
                let articles = queryResults.map { $0.toNativeType }
                
                return articles
            }
        
        return singleTrait
    }
    
    func articles() -> [Article] {
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
