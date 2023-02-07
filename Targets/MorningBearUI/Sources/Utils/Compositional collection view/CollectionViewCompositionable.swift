//
//  CollectionViewCompositionable.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/01/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// `UICollectionViewCompsitionalLayout`을 사용하기 위해 구현해야 하는 편의 함수 프로토콜
///
/// 현재로서는 자동완성 기능만 갖고 있음. 후에 조금 더 안전하고 편리한 방식으로 리팩토링 할 예정
public protocol CollectionViewCompositionable {
    /// 각 섹션에 `NSCollectionLayoutSection` 제공
    func layoutCollectionView()
    
    /// 콜렉션 뷰 디자인 요소 설정
    func designCollectionView()
    
    /// 딜리게이트 연결
    func connectCollectionViewWithDelegates()
    
    /// 셀 등록
    func registerCells()
}

extension CollectionViewCompositionable {
    /// `CollectionViewCompositionable`에서 구현한 모든 함수를 실행해줌
    public func configureCompositionalCollectionView() {
        layoutCollectionView()
        designCollectionView()
        connectCollectionViewWithDelegates()
        registerCells()
    }
}


/// `UICollectionViewCompositionalLayout`의 `NSCollectionLayoutSection`를
/// 재사용하기 위해 사용하는 함수 모음입니다
public struct CompositionalLayout {
    
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
