// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Anapistula",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Anapistula",
            targets: ["Anapistula"]),
        .executable(
            name: "anapistula-cli",
            targets: [ "anapistula-cli" ]
            ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser", from: "0.4.0"),
        .package(url: "https://github.com/Kitura/Kitura", from: "2.9.200"),
        .package(url: "https://github.com/Kitura/Kitura-net", from: "2.4.200"),
        .package(name: "KituraCORS", url: "https://github.com/Kitura/Kitura-CORS", from: "2.1.200"),
        .package(name: "Koba", url: "https://github.com/Kitura/koba", from: "0.2.200"),
        .package(url: "https://github.com/Kitura/SwiftyRequest.git", from: "3.2.200"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "anapistula-cli",
            dependencies: [
                "Anapistula",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "Anapistula",
            dependencies: [
                "Kitura",
                .product(name: "KituraNet", package: "Kitura-net"),
                "KituraCORS",
                "Koba",
            ]),
        .testTarget(
            name: "AnapistulaTests",
            dependencies: ["Anapistula", "SwiftyRequest"]),
    ]
)
