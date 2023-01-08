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
                           additionalTargets: (kit: String,
                                               UI: String,
                                               Network: String,
                                               Storage: String,
                                               Image: String
                           )) -> Project {
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: [
                                        TargetDependency.target(name: additionalTargets.kit),
                                        TargetDependency.target(name: additionalTargets.UI),
                                        TargetDependency.target(name: additionalTargets.Network),
                                        TargetDependency.target(name: additionalTargets.Storage),
                                        TargetDependency.target(name: additionalTargets.Image)
                                     ])
        
        targets += makeToolKitFrameworkTargets(name: additionalTargets.kit, platform: platform)
        targets += makeUIFrameworkTargets(name: additionalTargets.UI, platform: platform)
        targets += makeNetworkFrameworkTargets(name: additionalTargets.Network, platform: platform)
        targets += makeStorageFrameworkTargets(name: additionalTargets.Storage, platform: platform)
        targets += makeImageFrameworkTargets(name: additionalTargets.Image, platform: platform)

        
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
    
    // MARK: - Private
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeUIFrameworkTargets(name: String, platform: Platform) -> [Target] {
        // MARK: - Add new UI dependecies in here
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: ["Targets/\(name)/Resources/**"],
                             dependencies: [
                                .external(name: "RxSwift"),
                                .external(name: "RxCocoa"),
                                .target(name: "MorningBearKit")
                             ])
        
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        
        return [sources, tests]
    }
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeToolKitFrameworkTargets(name: String, platform: Platform) -> [Target] {
        // MARK: - Add new dependecies in here
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: [],
                             dependencies: [
                                .external(name: "RxSwift"),
                                .external(name: "RxKakaoSDK"),
                                .external(name: "Alamofire")
                             ])
        
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        
        return [sources, tests]
    }
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeNetworkFrameworkTargets(name: String, platform: Platform) -> [Target] {
        // MARK: - Add new UI dependecies in here
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: [],
                             dependencies: [
                                .external(name: "Moya"),
                                .external(name: "RxMoya"),
                                .external(name: "Apollo"),
                                .external(name: "StarWarsAPI"),
                                .external(name: "StarWarsAPITestMocks"),
                                .external(name: "MorningBearAPITestMocks"),
                                .external(name: "MorningBearAPI"),
                                .external(name: "Alamofire")
                             ])
        
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        
        return [sources, tests]
    }
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeStorageFrameworkTargets(name: String, platform: Platform) -> [Target] {
        // MARK: - Add new UI dependecies in here
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: [],
                             dependencies: [
                                .sdk(name: "c++", type: .library, status: .required),
                                .external(name: "FirebaseStorage"),
                                .external(name: "RxSwift"),
                             ],
                             settings: .settings(
                                base: [
                                    "OTHER_LDFLAGS": ["$(inherited)", "-ObjC"],
                                ]
                             ))
        
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        
        return [sources, tests]
    }
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeImageFrameworkTargets(name: String, platform: Platform) -> [Target] {
        // MARK: - Add new UI dependecies in here
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: ["Targets/\(name)/Resources/**"],
                             dependencies: [
                                
                             ])
        
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "\(organizationName).\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        
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
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}
