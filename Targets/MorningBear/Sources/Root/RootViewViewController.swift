//
//  RootViewViewController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/18.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import MorningBearNetwork
import MorningBearAuth

class RootViewViewController: UIViewController {
    private let authManager: MorningBearAuthManager = .shared
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue

        if authManager.isLoggedIn == true {
            showTabVC()
        } else {
            showLoginVC()
            bindLoginObservable()
        }
    }
    
    private func bindLoginObservable() {
        authManager.$isLoggedIn
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] isLoggedIn in
                guard let self else {
                    return
                }
                
                if isLoggedIn == true {
                    guard let token = self.authManager.token else {
                        fatalError("로그인 성공했는데 토큰이 왜 없음")
                    }
                    
                    self.loginSuccessful(token: token)
                } else {
                    self.showLoginVC()
                }
            }
            .disposed(by: bag)
    }
}

private extension RootViewViewController {
    func showTabVC() {
        let tabVC = TabBarController()
        addChild(tabVC)
        view.addSubview(tabVC.view)
        
        tabVC.didMove(toParent: self)
    }
    
    func showLoginVC() {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        
        let loginNavigationController = UINavigationController(
            rootViewController: loginVC
        )
        
        addChild(loginNavigationController)
        view.addSubview(loginNavigationController.view)
        
        loginNavigationController.didMove(toParent: self)
    }
    
    func logoutSuccessful() {
        for childVC in children {
            if childVC is TabBarController { // Find Tab bar ctrl
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        
        showLoginVC()
        Network.shared.removeToken()
    }
    
    /// Remove login view controller and show main view controller
    func loginSuccessful(token: String) {
        for childVC in children {
            if childVC is LoginViewController { // Find loginVC
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        
        showTabVC()
        Network.shared.registerToken(token: token)
    }
}
