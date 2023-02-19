//
//  RootViewViewController.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/18.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearAuth

class RootViewViewController: UIViewController {
    private let authManager: MorningBearAuthManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue

        if authManager.isLoggedIn {
            showTabVC()
        } else {
            showLoginVC()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    /// Remove login view controller and show main view controller
    func loginSuccessful() {
        for childVC in children {
            if childVC is UINavigationController { // Find loginVC
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        }
        
        showTabVC()
    }
}
