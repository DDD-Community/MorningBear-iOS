
import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    static var organizationName: String {
        return "com.dache"
    }
    
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String,
                           platform: Platform,
                           additionalTargets: (
                            Data: String,
                            Toolkit: String,
                            UI: String,
                            Network: String,
                            Storage: String,
                            Image: String,
                            DataProvider: String,
                            DataEditor: String,
                            Test: String,
                            Auth: String
                           )) -> Project {
        
        // MARK: - App level
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: [
                                        .target(name: additionalTargets.Toolkit),
                                        .target(name: additionalTargets.UI),
                                        .target(name: additionalTargets.Network),
                                        .target(name: additionalTargets.Image),
                                        .target(name: additionalTargets.DataProvider),
                                        .target(name: additionalTargets.DataEditor),
                                        .target(name: additionalTargets.Auth)
                                     ])
        
        targets += [
            // MARK: - WARNING - 상위 레벨 프레임워크에 하위 레벨 프레임워크를 Dependency로 넣지 말 것
            // MARK: - Data level
            makeTarget(name: additionalTargets.Storage, platform: platform,
                       dependencies: [
                        .sdk(name: "c++", type: .library, status: .required),
                        .external(name: "FirebaseStorage"),
                        .external(name: "RxSwift"),
                        .target(name: "MorningBearTestKit")
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking"),
                       ],
                       settings: .settings(
                        base: [
                            "OTHER_LDFLAGS": ["$(inherited)", "-ObjC"],
                        ]
                       )),
            makeTarget(name: additionalTargets.Data, platform: platform,
                       dependencies: []),
            
            // MARK: - General level
            makeTarget(name: additionalTargets.Toolkit, platform: platform,
                       dependencies: [
                        .external(name: "RxSwift"),
                        .external(name: "RxKakaoSDK"),
                        .external(name: "MorningBearAPI"),
                        .target(name: "MorningBearNetwork")
                       ]),
            makeTarget(name: additionalTargets.UI, platform: platform,
                       needsResource: true,
                       needTestResource: true,
                       dependencies: [
                        .external(name: "RxSwift"),
                        .external(name: "RxCocoa"),
                        .external(name: "Kingfisher"),
                        .external(name: "PanModal"),
                        .target(name: "MorningBearData"),
                        .target(name: "MorningBearKit")
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking"),
                        .target(name: "MorningBearTestKit")
                       ]),
            makeTarget(name: additionalTargets.Network, platform: platform,
                       dependencies: [
                        .external(name: "Apollo"),
                        .external(name: "MorningBearAPI"),
                        .external(name: "MorningBearAPITestMocks"),
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking")
                       ]),
            makeTarget(name: additionalTargets.Image, platform: platform,
                       dependencies: []),
            
            // MARK: - Function level
            makeTarget(name: additionalTargets.DataProvider, platform: platform,
                       dependencies: [
                        .target(name: "MorningBearData"),
                        .target(name: "MorningBearUI"),
                        .target(name: "MorningBearNetwork"),
                        .target(name: "MorningBearStorage")
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking"),
                        .target(name: "MorningBearTestKit")
                       ]),
            makeTarget(name: additionalTargets.DataEditor, platform: platform,
                       dependencies: [
                        .target(name: "MorningBearData"),
                        .target(name: "MorningBearUI"),
                        .target(name: "MorningBearNetwork"),
                        .target(name: "MorningBearStorage")
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking")
                       ]),
            makeTarget(name: additionalTargets.Test, platform: platform,
                       dependencies: [],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking"),
                       ]
                      ),
            makeTarget(name: additionalTargets.Auth,
                       platform: platform,
                       dependencies: [
                        .target(name: "MorningBearKit"),
                        .external(name: "RxSwift")
                       ],
                       additionalTestTarget: [
                        .external(name: "Quick"),
                        .external(name: "Nimble"),
                        .external(name: "RxBlocking"),
                        .target(name: "MorningBearTestKit")
                       ])
        ].flatMap { $0 }
        
        return Project(
            name: name,
            organizationName: organizationName,
            targets: targets
        )
    }
    
    // MARK: - Private
    private static func makeTarget(name: String,
                                   platform: Platform,
                                   needsResource: Bool = false,
                                   needTestResource: Bool = false,
                                   dependencies: [TargetDependency],
                                   additionalTestTarget: [TargetDependency] = [],
                                   settings: Settings? = nil)
    -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: needsResource ? ["Targets/\(name)/Resources/**"] : [],
                             dependencies: dependencies,
                             settings: settings)
        
        let testDependencies = [.target(name: name)] + additionalTestTarget
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: needTestResource ?  ["Targets/\(name)/Tests/Resources/**"] : [],
                           dependencies: testDependencies)
        
        return [sources, tests]
    }
    
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String,
                                       platform: Platform,
                                       dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIAppFonts": [
                "Pretendard-Thin.otf",
                "Pretendard-ExtraLight.otf",
                "Pretendard-Light.otf",
                "Pretendard-Regular.otf",
                "Pretendard-Medium.otf",
                "Pretendard-SemiBold.otf",
                "Pretendard-Bold.otf",
                "Pretendard-ExtraBold.otf",
                "Pretendard-Black.otf",
            ],
            "CFBundleURLTypes": [
                [
                    "CFBundleTypeRole": "Editor",
                    "CFBundleURLSchemes": ["kakao338eeb478a5cce01fe713b9100d0f42e"]
                ]
            ],
            "UIApplicationSceneManifest": [
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": [
                    "UIWindowSceneSessionRoleApplication": [
                        [
                            "UISceneConfigurationName": "Default Configuration",
                            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                        ],
                    ]
                ]
            ],
            "LSApplicationQueriesSchemes": ["kakaokompassauth"],
            "UIUserInterfaceStyle": "Dark",
            "NSCameraUsageDescription": "미라클 모닝을 기록하기 위해서는 사진 촬영이 필요합니다. 권한을 허용해주세요."
        ]
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            entitlements: "Local/Entitlements/\(name).entitlements",
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
                .external(name: "RxBlocking"),
                .external(name: "Nimble"),
                .external(name: "Quick")
            ])
        return [mainTarget, testTarget]
    }
}
