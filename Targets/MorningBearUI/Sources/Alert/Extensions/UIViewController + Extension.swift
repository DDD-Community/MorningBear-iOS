//
//  UIViewController + Extension.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showAlert(_ error: some Error) {
        let alert = error.alertify.uiAlert
        self.present(alert, animated: true)
    }
    
    public func showAlert(_ component: some Alertable) {
        let alert = component.uiAlert
        self.present(alert, animated: true)
    }
}
