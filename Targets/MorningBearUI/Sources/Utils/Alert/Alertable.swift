//
//  Alertable.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import UIKit

public protocol Alertable {
    var alertComponent: AlertComponent { get }
}

extension Alertable {
    public var uiAlert: UIAlertController {
        let controller = UIAlertController(title: self.alertComponent.title,
                                           message: self.alertComponent.message,
                                           preferredStyle: .alert)
        
        if let buttons = alertComponent.buttons {
            buttons.forEach { controller.addAction($0) }
        }
        
        return controller
    }
}

public struct AlertComponent {
    var title: String
    var message: String?
    var buttons: [UIAlertAction]?
}
