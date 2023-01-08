//
//  HorizontalCapsuleTableView.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// Generic하게 쓸만 한 `UICollectionViewDataSource`
public class GenericCollectionViewDataSource<CellType, Item>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate where CellType: UICollectionViewCell {
    let reuseIndentifier: String
    var items: [Item]
    let configure: (CellType, Item) -> Void
    
    public init(reuseIndentifier: String, items: [Item], configure: @escaping (CellType, Item) -> Void) {
        self.reuseIndentifier = reuseIndentifier
        self.items = items
        self.configure = configure
    }
    
    public func updateDatasource() {
        
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: indexPath)
                as? CellType else {
            return UICollectionViewCell()
        }
        
        let item = self.items[indexPath.row]
        configure(cell, item)
        
        return cell
    }
}

