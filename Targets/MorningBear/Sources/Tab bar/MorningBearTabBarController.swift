//
//  MorningBearTabBarController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/03.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

class MorningBearTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        setChildViewControllers()
    }

}

// MARK: - Internal tools
private extension MorningBearTabBarController {
    func configureTabBar() {
        tabBar.barTintColor = UIColor.white // TabBar 의 배경 색
        tabBar.tintColor = UIColor.purple // TabBar Item 이 선택되었을때의 색
        tabBar.unselectedItemTintColor = UIColor.black // TabBar Item 의 기본 색
    }
    
    func setChildViewControllers() {
        let mainViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")
        let socialViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC")
        let myPageViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        
//        mainViewController.tabBarItem.image = UIImage(named: "First") // TabBar Item 의 이미지
        mainViewController.tabBarItem.title = "First" // TabBar Item 의 이름
        
//        myPageViewController.tabBarItem.image = UIImage(named: "Second")
        socialViewController.tabBarItem.title = "Second"

//        myPageViewController.tabBarItem.image = UIImage(named: "Third")
        myPageViewController.tabBarItem.title = "Third"
        
        viewControllers = [
            mainViewController,
            socialViewController,
            myPageViewController
        ]
    }
}
