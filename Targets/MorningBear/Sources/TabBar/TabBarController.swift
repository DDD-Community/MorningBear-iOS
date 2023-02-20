//
//  TabBarController.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/02/10.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearUI

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC")
        //        let mainViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        
        self.tabBar.tintColor = .white
        self.viewControllers = [
            homeView(),
            myPageview()
        ]
    }
}

private extension TabBarController {
    func homeView() -> UIViewController {
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")

        homeVC.tabBarItem.image = MorningBearUIAsset.Images.tabHomeInactive.image.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = MorningBearUIAsset.Images.tabHomeActive.image.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "홈"
        
        let homeNavigationController = UINavigationController(
            rootViewController: homeVC
        ).configureMorningBearDefaultNavigationController()
        
        return homeNavigationController
    }
    
    func myPageview() -> UIViewController{
        let myPageVC = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPage")
        
        myPageVC.tabBarItem.image = MorningBearUIAsset.Images.tabMypageInactive.image.withRenderingMode(.alwaysOriginal)
        myPageVC.tabBarItem.selectedImage = MorningBearUIAsset.Images.tabMypageActive.image.withRenderingMode(.alwaysOriginal)
        myPageVC.tabBarItem.title = "마이페이지"
        
        let myPageNavigationController = UINavigationController(
            rootViewController: myPageVC
        ).configureMorningBearDefaultNavigationController()
        
        return myPageNavigationController
    }
}

private extension UINavigationController {
    func configureMorningBearDefaultNavigationController() -> UINavigationController {
        // Design navigation controller
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        
        // 네비게이션 타이틀 텍스트 설정
        appearance.titleTextAttributes = [
            .font: MorningBearUIFontFamily.Pretendard.bold.font(size: 20)
        ]
        
        let backButton = MorningBearUIAsset.Images.backArrow.image.withTintColor(.white, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backButton, transitionMaskImage: backButton)

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.topItem?.backButtonTitle = "" // 안 하면 뒤로가기 버튼에 글자 생김
        
        // TODO: TBD
//        self.hidesBarsOnSwipe = true

        return self
    }
}
