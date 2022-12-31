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
        
//        let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingVC")
// FIXME:
        let viewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home")
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }
}
