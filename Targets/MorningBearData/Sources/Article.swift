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
    public let title: String
    public let description: String
    public let weblink: URL?
    
    // FIXME: Fix default url
    public init(title: String, description: String, weblink: URL? = nil) {
        self.title = title
        self.description = description
        self.weblink = weblink
    }
    
    public func openURL(context: UIApplication) {
        let application = context
        let articleWebURL = self.weblink
        
        guard let articleWebURL else {
            return
        }
        
        if application.canOpenURL(articleWebURL) {
            application.open(articleWebURL)
        }
    }
}
