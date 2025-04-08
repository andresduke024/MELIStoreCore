// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MELIStoreCore",
    platforms: [.iOS(.v17), .macOS(.v15), .watchOS(.v7)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MELIStoreCore",
            targets: ["MELIStoreCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/andresduke024/swift-dependency-injector", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MELIStoreCore",
            dependencies: [
                .product(name: "SwiftDependencyInjector", package: "swift-dependency-injector"),
                .product(name: "Alamofire", package: "Alamofire")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ],
        ),
        .testTarget(
            name: "MELIStoreCoreTests",
            dependencies: [
                "MELIStoreCore",
                .product(name: "SwiftDependencyInjector", package: "swift-dependency-injector"),
            ]
        ),
    ]
)
