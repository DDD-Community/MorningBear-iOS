//
//  AccessoryConfiguration.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public struct AccessoryConfiguration {
    public let label: String
    public let accessory: UICellAccessory?
    public let accessoryAction: () -> Void
    
    public init(label: String, accessory: UICellAccessory?, accessoryAction: @escaping () -> Void) {
        self.label = label
        self.accessory = accessory
        self.accessoryAction = accessoryAction
    }
}

public extension AccessoryConfiguration {
    func controlSwitch(frame: CGRect) -> UISwitch {
        let swicth: UISwitch = UISwitch()
        swicth.layer.position = CGPoint(x: frame.width/2, y: frame.height - 200)
        swicth.tintColor = UIColor.orange
        swicth.isOn = true
        
        return swicth
    }
}

extension AccessoryConfiguration: Hashable {
    public static func == (lhs: AccessoryConfiguration, rhs: AccessoryConfiguration) -> Bool {
        lhs.label == rhs.label
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }
}
