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
    public static func app(name: String, platform: Platform, additionalTargets: (kit: String, UI: String)) -> Project {
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: [
                                        TargetDependency.target(name: additionalTargets.kit),
                                        TargetDependency.target(name: additionalTargets.UI)
                                     ])
        
        targets += makeToolKitFrameworkTargets(name: additionalTargets.kit, platform: platform)
        targets += makeUIFrameworkTargets(name: additionalTargets.UI, platform: platform)
        
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
                             resources: [],
                             dependencies: [
                                .external(name: "RxSwift")
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
                                .sdk(name: "c++", type: .library, status: .required),
                                .external(name: "Moya"),
                                .external(name: "RxMoya"),
                                .external(name: "RxSwift"),
                                .external(name: "Apollo"),
                                .external(name: "FirebaseStorage"),
                                .external(name: "StarWarsAPI"),
                                .external(name: "StarWarsAPITestMocks"),
                                .external(name: "RxKakaoSDK")
                                .external(name: "MorningBearAPITestMocks")
                                .external(name: "MorningBearAPI"),
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
    
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String,
                                       platform: Platform,
                                       dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
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
