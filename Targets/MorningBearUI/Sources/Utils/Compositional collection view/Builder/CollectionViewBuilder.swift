//
//  CollectionViewBuilder.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/02/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit


import RxSwift
import RxCocoa

public typealias AnyCustomCellType = any CustomCellType.Type

public typealias LayoutSectionProvider = UICollectionViewCompositionalLayoutSectionProvider
public typealias LayoutConfiguration = UICollectionViewCompositionalLayoutConfiguration

/// 콜렉션 뷰 만들 떄 쓰는 빌더
///
/// - Example: `self.collectionView = collectionViewBuilder.build()`
public final class CollectionViewBuilder<Section, Item>
where Section: Hashable & CaseIterable,
      Item: Hashable
{
    public typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Item>
    public typealias CellProvider =  DiffableDataSource.CellProvider
    public typealias SupplementaryViewProvider = DiffableDataSource.SupplementaryViewProvider
    public typealias ObservableProvider = (Section) -> UpdatePolicy
    
    /// 외부에서 이미 선언된 `collectionView`를 가져와 베이스 콜렉션 뷰로 선언합니다
    private let base: UICollectionView
    
    /// 사용할 섹션  목록입니다.
    public let sections: [Section]
    /// `register`할 아이템 셀의 목록을 저장합니다.
    public let cellTypes: [AnyCustomCellType]
    /// `register`할 헤더, 혹은 푸터에 사용되는 셀을 저장합니다. `Kind`라는 `enum` 타입을 갖습니다.
    public let supplementarycellTypes: [Kind]
    /// `delegate` 선언부를 가져옵니다
    private let delegate: UICollectionViewDelegate
    /// 디자인 옵션을 포함한 빌드 옵션이 포함되어 있습니다.
    private let option: CollectionViewBuilderOption
    /// `dataSource`는 뷰 컨트롤러에 저장해둘 것. 안 하면 데이터 표시가 안됨...
    private var dataSource: DiffableDataSource
    /// 콜렉션 뷰에 전달할 레이아웃입니다.
    private var layout: UICollectionViewLayout
    
    /// 옵저버블 바인딩 할거 넣어주는 프로바이더. 빌더나 인터셉터로 새로 분리할까 싶기도
    private let observableProvider: ObservableProvider
    private let bag: DisposeBag

    /// 나머지는 대충 보면 알 듯
    ///
    ///
    /// `MyPageViewController` 보면 대충 어떻게 되는지 감이 옴
    /// - Parameters:
    ///     - sections: 쓸 섹션 어레이로 다 넣어주기
    ///     - cellTypes: 쓸 셀 타입 어레이로 다 넣어주기. 프로토콜 `CustomCellType` 따라야 함
    ///     - supplementaryCellTypes: 헤더나 푸터의 경우 여기에 셀 타입 넣어주기
    ///     - cellProvider: `cellForRowAt`이랑 비슷한 기능의 클로저
    ///     - supplementaryViewProvider: 위랑 같은데 헤더 푸터 전용
    ///     - observableProvider: 뷰모델에 옵저버블 어떻게 묶을지 넣어주기
    ///     - layoutSectionProvider: 컴포지셔널 레이아웃 섹션별로 넣어주기
    ///
    public init(
        base collectionView: UICollectionView,
        sections: [Section],
        cellTypes: [AnyCustomCellType],
        supplementarycellTypes: [Kind] = [],
        cellProvider: @escaping CellProvider,
        supplementaryViewProvider: SupplementaryViewProvider? = nil,
        observableProvider: @escaping ObservableProvider,
        layoutSectionProvider: @escaping LayoutSectionProvider,
        layoutConfiguration: LayoutConfiguration? = nil,
        delegate: UICollectionViewDelegate,
        disposeBag: DisposeBag,
        option: CollectionViewBuilderOption = .init()
    ) {
        self.base = collectionView
        
        self.sections = sections
        self.cellTypes = cellTypes
        self.supplementarycellTypes = supplementarycellTypes
        
        self.observableProvider = observableProvider
        
        let dataSourceBuilder = DiffableDataSourceBuilder<Section, Item>(
            collectionView: base,
            sections: sections,
            cellProvider: cellProvider,
            supplementaryViewProvider: supplementaryViewProvider
        )
        self.dataSource = dataSourceBuilder.build()
        
        let layoutBuilder = CompositionalLayoutBuilder(
            sectionProvider: layoutSectionProvider,
            layoutConfiguration: layoutConfiguration
        )
        self.layout = layoutBuilder.build()
        self.layout.register(BackgroundReusableView.self, forDecorationViewOfKind: "BackgroundReusableView")
        
        self.delegate = delegate
        self.option = option
        self.bag = disposeBag
    }
    
    enum BuilderError: Error {
        case notConfigured(_ location: String)
    }
}

extension CollectionViewBuilder {
    private func registerCells() {
        cellTypes.forEach { $0.register(to: base) }
     
        supplementarycellTypes.forEach { kind in
            switch kind {
            case .header(let type):
                type.registerHeader(to: base)
            case .footer(let type):
                type.registerFooter(to: base)
            }
        }
    }
    
    private func configureDataSource() {
        base.dataSource = self.dataSource
    }
    
    private func configureObservables() {
        sections.forEach { [weak self] section in
            guard let self else { return }
            
            switch observableProvider(section) {
            case .replace(let observable):
                bindDriver(from: observable, in: bag) { items in
                    self.dataSource.replaceDataSource(in: section, to: items)
                }
                
            case .append(let observable):
                bindDriver(from: observable, in: bag) { items in
                    self.dataSource.updateDataSource(in: section, with: items)
                }
            }
        }
    }
    
    private func configureLayout() {
        base.collectionViewLayout = self.layout
    }
    
    private func configureUI() {
        base.isScrollEnabled = option.isScrollEnabled
        base.showsHorizontalScrollIndicator = option.showsHorizontalScrollIndicator
        base.showsVerticalScrollIndicator = option.showsVerticalScrollIndicator
        base.backgroundColor = option.backgroundColor
        base.clipsToBounds = option.clipsToBounds
    }
    
    private func configureDelegate() {
        base.delegate = delegate
    }
}

public extension CollectionViewBuilder {
    func build() -> (collectionView: UICollectionView, dataSource: DiffableDataSource) {
        guard Section.allCases.count == sections.count else {
            fatalError("등록되지 않은 섹션이 있습니다. 확인해주세요!")
        }
        
        registerCells()
        configureDataSource()
        configureLayout()
        configureUI()
        configureDelegate()
        configureObservables()
        
        return (collectionView: base, dataSource: dataSource)
    }
    
    enum UpdatePolicy {
        case replace(_ observable: Observable<[Item]>)
        case append(_ observable: Observable<[Item]>)
    }
    
    enum Kind {
        case header(AnyCustomCellType)
        case footer(AnyCustomCellType)
    }
}

public struct CollectionViewBuilderOption {
    let isScrollEnabled: Bool
    let showsHorizontalScrollIndicator: Bool
    let showsVerticalScrollIndicator: Bool
    let backgroundColor: UIColor
    let clipsToBounds: Bool
    let interSectionSpacing: CGFloat
    
    public init(
        isScrollEnabled: Bool = true,
        showsHorizontalScrollIndicator: Bool = false,
        showsVerticalScrollIndicator: Bool = false,
        backgroundColor: UIColor = .clear,
        clipsToBounds: Bool = true,
        interSectionSpacing: CGFloat = 0
    ) {
        self.isScrollEnabled = isScrollEnabled
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.backgroundColor = backgroundColor
        self.clipsToBounds = clipsToBounds
        
        self.interSectionSpacing = interSectionSpacing
    }
}

@inline(__always)
public func bindDriver<Item>(
    from observable: Observable<[Item]>,
    in bag: DisposeBag,
    _ doing: @escaping ([Item]) -> ()
) {
    observable
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .asDriver(onErrorJustReturn:[])
        .drive { doing($0) }
        .disposed(by: bag)
}
