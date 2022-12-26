//
//  CompositionLayoutProvider.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// `UICollectionViewCompositionalLayout`의 `NSCollectionLayoutSection`를
/// 재사용하기 위해 사용하는 함수 모음입니다
struct CompositionalLayoutProvider {    
    /// 나의 최근 미라클 모닝 등에서 사용되는 NxN 그리드를 위한 레이아웃 섹션
    func getRecentMorningLayoutSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 7.5, leading: 7.5, bottom: 7.5, trailing: 7.5)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.widthDimension
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // footer
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [header, footer]
        
        return section
    }
    
    /// 내가 모은 배지 등에서 사용되는 수평 스크롤 레이아웃 섹션
    func getBadgeLayoutSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(1.0/4.0)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 4
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
