//
//  UIImagePicker+Extension.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// UIIMagePicker에는 고질적인 버그가 있음. 뭐냐면 사진을 찍고 나서 크롭하는 뷰에서 사진이 안 움직임.
/// 이를 고쳐주는 익스텐션임. 자세한 내용 아래 링크 참조
/// https://stackoverflow.com/questions/51335187/uiimagepickercontroller-not-properly-cropping-selected-image
extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }

    open override var prefersStatusBarHidden: Bool {
        return true
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixCannotMoveEditingBox()
    }
    
    private func fixCannotMoveEditingBox() {
        if let cropView = cropView, let scrollView = scrollView, scrollView.contentOffset.y == 0 {
            let top: CGFloat = cropView.frame.minY + self.view.frame.minY
            let bottom = scrollView.frame.height - cropView.frame.height - top
            scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
            
            var offset: CGFloat = 0
            if scrollView.contentSize.height > scrollView.contentSize.width {
                offset = 0.5 * (scrollView.contentSize.height - scrollView.contentSize.width)
            }
            scrollView.contentOffset = CGPoint(x: 0, y: -top + offset)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.fixCannotMoveEditingBox()
        }
    }
    
    private var cropView: UIView? {
        return findCropView(from: self.view)
    }
    
    private var scrollView: UIScrollView? {
        return findScrollView(from: self.view)
    }
    
    private func findCropView(from view: UIView) -> UIView? {
        let width = UIScreen.main.bounds.width
        let size = view.bounds.size
        if width == size.height, width == size.height {
            return view
        }
        for view in view.subviews {
            if let cropView = findCropView(from: view) {
                return cropView
            }
        }
        return nil
    }
    
    private func findScrollView(from view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        for view in view.subviews {
            if let scrollView = findScrollView(from: view) {
                return scrollView
            }
        }
        return nil
    }
}
