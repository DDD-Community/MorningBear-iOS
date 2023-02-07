//
//  File.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

extension Error {
    // Help turning Error into Alertable
    var alertify: some Alertable {
        return ErrorAlert(self)
    }
}

fileprivate struct ErrorAlert<T>: Alertable where T: Error {
    private let error: T
    let alertComponent: AlertComponent
    
    init(_ error: T) {
        self.error = error
        self.alertComponent = AlertComponent(title: "앗..!",
                                             message: "\(error.localizedDescription)",
                                             buttons: [UIAlertAction(title: "OK", style: .default)])
    }
}
