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
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")
        
        let loginNavigationController = UINavigationController(
            rootViewController: loginVC
        ).configureMorningBearDefaultNavigationController()
        loginNavigationController.tabBarItem.image = MorningBearUIAsset.Images.bonfire.image
        
        let homeNavigationController = UINavigationController(
            rootViewController: homeVC
        ).configureMorningBearDefaultNavigationController()
        homeNavigationController.tabBarItem.image = MorningBearUIAsset.Images.exercise.image
        
        self.viewControllers = [
            loginVC,
            homeNavigationController
        ]
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
