//
//  MyPageSettingViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

//FIXME: this
import MorningBearData

import MorningBearUI
import MorningBearAuth

class MyPageSettingViewModel {
    typealias CellHandler = () -> Void
    
    private let authManager: MorningBearAuthManager
    
    var logoutCellAction: CellHandler?
    var withdrawalCellAction: CellHandler?
    var supportCellAction: CellHandler?
    
    let profile = Profile(
        imageURL: URL(string: "www.naver.com")!,
        nickname: "ss",
        buttonText: Profile.ButtonContext(buttonText: "정보 수정하기", buttonAction: {
            print("Tapped")
        })
    )

    private(set) var settings: [AccessoryConfiguration] = []
    
    init(_ authManager: MorningBearAuthManager = .shared) {
        self.authManager = authManager
        
        self.settings = configureSettingCell()
    }
}

extension MyPageSettingViewModel {
    func logout() {
        self.authManager.logout()
        
    }
    
    func withdrawal() {
        self.authManager.withdrawal()
    }
}

private extension MyPageSettingViewModel {
    func configureSettingCell() -> [AccessoryConfiguration] {
        return [
            .init(label: "로그아웃", accessory: .disclosureIndicator(), accessoryAction: { [weak self] in
                guard let self else {
                    return
                }
                self.logoutCellAction?()
            }),
            .init(label: "회원탈퇴", accessory: .disclosureIndicator(), accessoryAction: { [weak self] in
                guard let self else {
                    return
                }
                self.withdrawalCellAction?()
            }),
            .init(label: "문의하기", accessory: .disclosureIndicator(), accessoryAction: { [weak self] in
                guard let self else {
                    return
                }
                self.supportCellAction?()
            }),
            .init(label: "현재버전", accessory: .label(text: "\(appVersion)"), accessoryAction: {})
        ]
    }
}

private extension MyPageSettingViewModel {
    var appVersion: String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return ""
        }
        
        return version
    }
}
