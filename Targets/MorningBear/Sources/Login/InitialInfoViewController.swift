//
//  InitialInfoViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

class InitialInfoViewController: UIViewController {
    
    private lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageVC
    }()
    
    private var infoSettingViewControllers: [UIViewController] = {
        let storyboard = UIStoryboard(name: "InitialInfo", bundle: nil)
        return [
            storyboard.instantiateViewController(withIdentifier: "SetWakeupTime"),
            storyboard.instantiateViewController(withIdentifier: "SetActivity"),
            storyboard.instantiateViewController(withIdentifier: "SetGoal"),
            storyboard.instantiateViewController(withIdentifier: "SetProfile")
        ]
    }()
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.backgroundColor = MorningBearUIAsset.Colors.primaryDefault.color
            nextButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageView()
        setDelegate()
    }
    
    private func setPageView() {
        view.addSubview(pageViewController.view)
        view.sendSubviewToBack(pageViewController.view)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        if let firstVC = infoSettingViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    private func setDelegate() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
}

extension InitialInfoViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = infoSettingViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return infoSettingViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = infoSettingViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == infoSettingViewControllers.count {
            return nil
        }
        return infoSettingViewControllers[nextIndex]
    }
}
