//
//  SceneDelegate.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/07.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxKakaoSDKAuth
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let tabbarController = TabBarController()
        let navigationControlller = UINavigationController(
            rootViewController: tabbarController
        ).configureMorningBearDefaultNavigationController()

        window.rootViewController = navigationControlller
        window.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
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
