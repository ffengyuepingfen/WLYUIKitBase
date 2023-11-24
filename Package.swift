// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WLYUIKitBase",
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
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(path: "../WLYUIKitBaseOC")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WLYUIKitBase",
            dependencies: ["OC"],
            resources: [
                .process("Resources")
            ]),
        .target(
            name: "OC",
            dependencies: []),
        .testTarget(
            name: "WLYUIKitBaseTests",
            dependencies: ["WLYUIKitBase"]),
    ]
)
