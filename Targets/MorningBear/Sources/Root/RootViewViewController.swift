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

import MorningBearAPI

class RootViewViewController: UIViewController {
    private let authManager: MorningBearAuthManager = .shared
    private let bag = DisposeBag()
    
    private lazy var loginViewController: UIViewController? = {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "Login")
        
        let loginNavigationController = UINavigationController(
            rootViewController: loginVC
        )
        
        return loginNavigationController
    }()
    
    private lazy var tabController: UIViewController? = {
        let tabVC = TabBarController()
        
        return tabVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        if authManager.isLoggedIn == true {
            addTabVC()
        } else {
            addLoginVC()
        }

        bindLoginObservable()
    }
    
    private func bindLoginObservable() {
        authManager.$isLoggedIn
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
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
                    self.logoutSuccessful()
                }
            }
            .disposed(by: bag)
    }
}

private extension RootViewViewController {
    func addTabVC() {
        guard let tabVC = tabController else {
            return
        }
        
        addChild(tabVC)
        view.addSubview(tabVC.view)
        tabVC.didMove(toParent: self)
    }
    
    func addLoginVC() {
        guard let loginVC = loginViewController else {
            return
        }
        
        addChild(loginVC)
        view.addSubview(loginVC.view)
        loginVC.didMove(toParent: self)
    }
    
    func logoutSuccessful() {
        if let vc = children.first(where: { $0 === tabController }) {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
            
        }
        
        DispatchQueue.main.async {
            self.addLoginVC()
        }
        
        Network.shared.removeToken()
    }
    
    /// Remove login view controller and show main view controller
    func loginSuccessful(token: String) {
        if let vc = children.first(where: { $0 === loginViewController }) {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        Network.shared.registerToken(token: token)
        Network.shared.apollo.rx.perform(
            mutation: SaveMyInfoMutation(input: UserInput())
        )
        .observe(on: MainScheduler.instance)
        .subscribe(with: self, onSuccess: { weakSelf, _ in
            DispatchQueue.main.async {
                weakSelf.addTabVC()
            }
        })
        .disposed(by: bag)
    }
}
