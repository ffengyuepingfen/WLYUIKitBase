// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WLYUIKitBase",
    defaultLocalization: "zh-Hans",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WLYUIKitBase",
            targets: ["WLYUIKitBase"]),
    ],
    dependencies: [
        .package(url: "https://gitee.com/laoyouHome/TZImagePicker.git", .upToNextMajor(from: "3.8.5")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WLYUIKitBase",
            dependencies: ["OC","TZImagePicker"],
            resources: [
                .process("Resources")
            ]),
        .target(
            name: "OC",
            dependencies: [],
            resources: [
                            .process("Resources")
                        ]),
        .testTarget(
            name: "WLYUIKitBaseTests",
            dependencies: ["WLYUIKitBase"]),
    ]
)
