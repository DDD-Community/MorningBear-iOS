//
//  LayoutBuilder.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/02/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

// MARK: Layout builder
struct CompositionalLayoutBuilder {
    private let layoutProvider = CompositionalLayoutProvider()
    
    private let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider
    private let layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration?
    
    init(
        sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider,
        layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration?
    ) {
        self.sectionProvider = sectionProvider
        self.layoutConfiguration = layoutConfiguration
    }
}

extension CompositionalLayoutBuilder {
    func build() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        if let layoutConfiguration {
            layout.configuration = layoutConfiguration
        }
        
        return layout
    }
}
