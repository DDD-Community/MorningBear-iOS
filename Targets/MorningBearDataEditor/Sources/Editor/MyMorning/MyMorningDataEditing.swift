//
//  MyMorningDataEditing.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/25.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import RxSwift

import MorningBearData

// MARK: - Define sub protocol
public protocol MyMorningDataEditing: DataEditing {
    func perform<Mutation: MyMorningMutable>(_ mutation: Mutation) -> Single<Mutation.ResultType>
    
    // Wrapper func for convinience
    func request(info: MorningRegistrationInfo) -> Single<(photoLink: String, updateBadges: [Badge])>
}

public protocol MyMorningMutable: Mutable {}
