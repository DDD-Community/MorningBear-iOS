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
    private let authManager: MorningBearAuthManager
    
    let profile = Profile(
        imageURL: URL(string: "www.naver.com")!,
        nickname: "ss",
        buttonText: Profile.ButtonContext(buttonText: "정보 수정하기", buttonAction: {
            print("Tapped")
        })
    )

    private(set) var settings: [AccessoryConfiguration]
    
    init(_ authManager: MorningBearAuthManager = .shared) {
        self.authManager = authManager
        
        self.settings = []
        self.settings = [
            .init(label: "로그아웃", accessory: .disclosureIndicator(), accessoryAction: { [weak self] in
                guard let self else {
                    return
                }
                self.handleLogout()
            }),
           .init(label: "회원탈퇴", accessory: .disclosureIndicator(), accessoryAction: {}),
           .init(label: "문의하기", accessory: .disclosureIndicator(), accessoryAction: {}),
           .init(label: "현재버전", accessory: .label(text: "x.x.x"), accessoryAction: {})
       ]
    }
}

private extension MyPageSettingViewModel {
    func handleLogout() {
        self.authManager.logout()
    }
}
