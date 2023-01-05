//
//  RegisterMorningViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import MorningBearKit

class RegisterMorningViewModel {
    let timeFormatter = MorningBearDateFormatter.timeFormatter
    
    func registerMorningInformation(info: MorningRegistrationInfo) {
        print(info)
    }
}
