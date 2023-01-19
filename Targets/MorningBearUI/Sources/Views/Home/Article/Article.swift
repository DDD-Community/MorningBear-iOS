//
//  Article.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public struct Article: Hashable, Identifiable {
    public let id: UUID = .init()
    let image: UIImage
    let title: String
    let description: String
    let weblink: URL
    
    // FIXME: Fix default url
    public init(image: UIImage, title: String, description: String,
                weblink: URL = URL(string: "https://www.naver.com")!) {
        self.image = image
        self.title = title
        self.description = description
        self.weblink = weblink
    }
    
    public func openURL(context: UIApplication) {
        let application = context
        let articleWebURL = self.weblink
        
        if application.canOpenURL(articleWebURL) {
            application.open(articleWebURL)
        }
    }
}
