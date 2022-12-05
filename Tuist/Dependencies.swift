//
//  Dependencies.swift
//  Config
//
//  Created by 이영빈 on 2022/11/28.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
        .remote(
            url: "https://github.com/Moya/Moya.git",
            requirement: .upToNextMajor(from: "15.0.0")
        ),
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.5.0")
        ),
        .remote(
            url: "https://github.com/apollographql/apollo-ios.git",
            requirement: .upToNextMajor(from: "1.0.5")
        ),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "9.0.0")),
        .local(path: .relativeToRoot("Local/GraphQL/StarWarsAPI"))
    ],
    platforms: [.iOS]
)
