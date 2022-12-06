// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "MorningBearAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "MorningBearAPI", targets: ["MorningBearAPI"]),
    .library(name: "MorningBearAPITestMocks", targets: ["MorningBearAPITestMocks"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "MorningBearAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "MorningBearAPITestMocks",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "MorningBearAPI"),
      ],
      path: "./TestMocks"
    ),
  ]
)
