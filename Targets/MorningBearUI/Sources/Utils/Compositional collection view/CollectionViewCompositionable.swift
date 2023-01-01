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
