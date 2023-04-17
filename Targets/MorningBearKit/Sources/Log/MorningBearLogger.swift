//
//  MorningBearLogger.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/25.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MorningBearLogger {
    public static func track(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        print("[❌ Error]: '\(error)' occurred from \(function) \(file):\(line)")
    }
}
