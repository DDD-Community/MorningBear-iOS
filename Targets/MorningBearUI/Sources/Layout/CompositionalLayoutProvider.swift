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
public struct CompositionalLayoutProvider {
    /// 내 상태같은 1개 셀만을 표기하는 레이아웃 섹션
    public func plainLayoutSection(height: CGFloat) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = commomSectionInset
        
        return section
    }
    
    /// 나의 최근 미라클 모닝 등에서 사용되는 스크롤 없는 NxN 그리드를 위한 레이아웃 섹션
    ///
    /// - Parameters:
    ///     - column: 한 행에 표시되는 아이템 개수
    public func staticGridLayoutSection(column: Int) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedWidthFraction(column)-0.01),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.widthDimension
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(7.5)

        // header
        let header = commonHeader

        // footer
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(76)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
//        footer.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [header, footer]
        
        section.contentInsets = commomSectionInset
        section.interGroupSpacing = 7.5
        
        return section
    }
    
    /// 내가 모은 배지 등에서 사용되는 수평 스크롤 레이아웃 섹션
    ///
    /// - Parameters:
    ///     - cellWidth: 각 셀의 가로길이. 세로길이는 속한 그룹의 높이랑 일치함.
    public func horizontalScrollLayoutSection(column: Int) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedWidthFraction(column)),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)

        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(176)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let header = commonHeader
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]
        section.contentInsets = commomSectionInset
        
        return section
    }
    
    public init() {}
}

// MARK: Internal tools
extension CompositionalLayoutProvider {
    /// (1 / 열 개수) = 한 열 당 셀이 차지하는 가로 크기 비율
    private func calculatedWidthFraction(_ column: Int) -> CGFloat {
        1.0 / CGFloat(column)
    }
    
    /// 섹션 국룰 좌우 패딩(좌 20, 우 20)
    private var commomSectionInset: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    }
    
    /// 공용으로 쓰이는 헤더 래핑한 것
    private var commonHeader: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(45)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        
//        header.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(20))
        return header
    }
}