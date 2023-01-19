//
//  UIPageViewController + Extension.swift
//  MorningBearUI
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

extension UIPageViewController {

    public func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    public func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}
