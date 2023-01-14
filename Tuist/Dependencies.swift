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
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk",
            requirement: .upToNextMajor(from: "9.0.0")
        ),
        .remote(
            url: "https://github.com/kakao/kakao-ios-sdk-rx",
            requirement: .branch("master")
        ),
        .remote(
            url: "https://github.com/Alamofire/Alamofire",
            requirement: .upToNextMajor(from: "5.6.0")
        ),
        .remote(
            url: "https://github.com/Quick/Quick",
            requirement: .upToNextMajor(from: "6.1.0")
        ),
        .remote(
            url: "https://github.com/Quick/nimble",
            requirement: .upToNextMajor(from: "11.2.0")
        ),
        .local(path: .relativeToRoot("Local/GraphQL/StarWarsAPI")),
        .local(path: .relativeToRoot("Local/GraphQL/MorningBearAPI"))
    ],
    platforms: [.iOS]
)
