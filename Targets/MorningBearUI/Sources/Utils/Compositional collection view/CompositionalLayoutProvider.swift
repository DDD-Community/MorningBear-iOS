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
    public func verticalScrollLayoutSection(showItemCount count: Int) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1.0 / CGFloat(count) - 0.05)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        section.contentInsets = commomSectionInset
        section.contentInsets.top += 12
        section.interGroupSpacing = 12
        
        return section
    }
    
    public func horizontalScrollLayoutSection(showItemCount count: Int) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(count)),
            heightDimension: .fractionalHeight(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 6
        
        return section
    }
    
    public func horizontalScrollLayoutSection(showItemCount count: Int, height: CGFloat) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(count)),
            heightDimension: .estimated(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 6
        
        return section
    }
    
    public func horizontalScrollLayoutSectionWithHeader(showItemCount count: Int, height: CGFloat) -> NSCollectionLayoutSection {
        let section = horizontalScrollLayoutSection(showItemCount: count, height: height)
        section.boundarySupplementaryItems.append(commonHeader)
        section.decorationItems = [
           NSCollectionLayoutDecorationItem.background(elementKind: "BackgroundReusableView")
        ]
        
        return section
    }
    
    /// 내 상태같은 1개 셀만을 표기하는 레이아웃 섹션
    ///
    /// 통용 인셋(좌우 20)을 위해 사용
    public func plainLayoutSection(height: CGFloat) -> NSCollectionLayoutSection {
        let section = plainLayoutSection(height: height, inset: commomSectionInset)
        return section
    }
    
    /// 내 상태같은 1개 셀만을 표기하는 레이아웃 섹션
    ///
    /// 디바이더가 있을 경우를 위해 인셋 커스텀 가능
    ///
    /// - Parameters:
    ///     - height: 해당 섹션 높이.
    ///     `estimated`라 셀 내부 컴포넌트 크기에 따라 동적으로 결정되며 따라서 정확히 해당 높이로 설정되지 않을 수 있음
    public func plainLayoutSection(height: CGFloat, inset: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
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
        section.contentInsets = inset
        
        return section
    }
    
    /// 나의 최근 미라클 모닝 등에서 사용되는 스크롤 없는 NxN 그리드를 위한 레이아웃 섹션
    ///
    /// - Parameters:
    ///     - column: 한 행에 표시되는 아이템 개수
    public func staticGridLayoutSection(column: Int) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedFraction(column)-0.015),
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
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [header, footer]
        
        section.contentInsets = commomSectionInset
        section.interGroupSpacing = 7.5
        
        return section
    }
    
    /// 내가 획득한 배지 등에서 사용되는 스크롤 있는  NxM 그리드를 위한 레이아웃 섹션
    ///
    /// 푸터 & 헤더 없음, 기본 높이 118, 기본 인셋 좌우 10
    ///
    /// - Parameters:
    ///     - column: 한 행에 표시되는 아이템 개수
    public func dynamicGridLayoutSection(column: Int) -> NSCollectionLayoutSection {
        let height: CGFloat = 118
        let inset = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = dynamicGridLayoutSection(column: column, height: height, inset: inset)
        
        return section
    }
    
    public func dynamicGridLayoutSection(column: Int, row: Int) -> NSCollectionLayoutSection {
        let section = dynamicGridLayoutSection(column: column, row: row, spacing: 12)
                
        return section
    }
    
    public func dynamicGridLayoutSection(column: Int, row: Int, spacing: CGFloat) -> NSCollectionLayoutSection {
        let spacing: CGFloat = 12
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedFraction(column)),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing/2, leading: spacing/2, bottom: spacing/2, trailing: spacing/2)

        // stacking group
        let stackingGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(calculatedFraction(row+1))
        )
        let stackingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: stackingGroupSize,
            subitems: [item]
        )

        // section
        let section = NSCollectionLayoutSection(group: stackingGroup)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = sectionInset(estimated: 20, itemSpacing: spacing)

        return section
    }
    
    public func dynamicGridLayoutSection(
        column: Int,
        height: CGFloat,
        inset: NSDirectionalEdgeInsets,
        spacing: CGFloat = 40
    ) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedFraction(column)),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // row group
        let rowGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(height)
        )
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rowGroupSize,
            subitems: [item]
        )
        
        // stacking group(stacking row groups)
        let stackingGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let stackingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: stackingGroupSize,
            subitems: [rowGroup]
        )
        stackingGroup.interItemSpacing = .fixed(spacing)
        
        // section
        let section = NSCollectionLayoutSection(group: stackingGroup)
        section.orthogonalScrollingBehavior = .none
        
        section.contentInsets = narrowSectionInset
        section.interGroupSpacing = 7.5
        
        return section
    }
    
    
    /// 나의 미라클 모닝 상세 뷰에서 사용되는 정사각형 셀 그리드를 위한 레이아웃 섹션
    ///
    /// 스크롤 가능, 헤더 있음
    public func squareCellDynamicGridLayoutSection(
        column: Int,
        needsHeader: Bool = true,
        itemSpacing: CGFloat = 15
    ) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedFraction(column)),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemInset = itemSpacing / 2
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)

        // row group
        let rowGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.widthDimension
        )
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rowGroupSize,
            subitems: [item]
        )

        // section
        let section = NSCollectionLayoutSection(group: rowGroup)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 0
        
        if needsHeader {
            // Add header
            let header = commonHeader
            header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // FIXME: 아닌 것 같음
            section.boundarySupplementaryItems = [header]
        }
        
        section.contentInsets = narrowSectionInset
        return section
    }
    
    /// 내가 모은 배지 등에서 사용되는 수평 스크롤 레이아웃 섹션
    ///
    /// - Parameters:
    ///     - column: 한 행에 표시되는 아이템 개수
    public func horizontalScrollLayoutSection(column: Int, groupWidthFraction: CGFloat = 0.8) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(calculatedFraction(column)),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)

        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupWidthFraction),
            heightDimension: .estimated(180)
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
    
    public func divier(height: CGFloat = 6) -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public init() {}
}


public extension CompositionalLayoutProvider {
    
}

// MARK: Internal tools
extension CompositionalLayoutProvider {
    /// (1 / 열 개수) = 한 열 당 셀이 차지하는 가로 크기 비율
    private func calculatedFraction(_ elementCount: Int) -> CGFloat {
        1.0 / CGFloat(elementCount)
    }
    
    private func sectionInset(estimated: CGFloat, itemSpacing: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: 0, leading: estimated - itemSpacing, bottom: 0, trailing: estimated - itemSpacing)

    }
    
    /// 섹션 국룰 좌우 패딩(좌 20, 우 20)
    private var commomSectionInset: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    }
    
    /// 조금 좁은 섹션 좌우 패딩(좌 15, 우 15) -> 나의 배지 등에서 사용
    private var narrowSectionInset: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
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
        
        return header
    }
}

public struct CompositionalLayoutOption {
    let heihgt: CGFloat
    let width: CGFloat
    
}
