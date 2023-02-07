//
//  Activity.swift
//  MorningBearUI
//
//  Created by 이건우 on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public struct Activity {
    let id: String
    let image: UIImage
    let name: String
    
    public init(id: String, image: UIImage, name: String) {
        self.id = id
        self.image = image
        self.name = name
    }
}
