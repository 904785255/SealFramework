// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    products: [
        .singleTargetLibrary("Models"),
        .singleTargetLibrary("AppAccount"),
    ],
    dependencies: [
        .package(url: "https://github.com/reers/ReerCodable.git", from: "1.2.6"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", branch: "master"),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.4")),

    ],
    targets: [
        .target(
            name: "AppAccount",
            dependencies: [
                "Models",
                .product(name: "KeychainSwift", package: "keychain-swift"),
                .product(name: "Collections", package: "swift-collections")
            ]
        ),
        .target(
            name: "Models",dependencies:[
                .product(name: "ReerCodable", package: "ReerCodable"),
            ]),

    ]
)
extension Product {

    static func singleTargetLibrary(_ name: String) -> Product {
        .library(name: name, type: .static, targets: [name])
    }
}
