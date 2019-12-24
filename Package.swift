// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "anapistula",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.4.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.9.1"),
        .package(url: "https://github.com/IBM-Swift/Kitura-net", from: "2.4.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CORS", from: "2.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "anapistula",
            dependencies: [ "AppCore", "SPMUtility" ]),
        .target(
            name: "AppCore",
            dependencies: [ "Kitura", "KituraNet", "KituraCORS" ]
            ),
        .testTarget(
            name: "anapistulaTests",
            dependencies: ["anapistula"]),
    ]
)
