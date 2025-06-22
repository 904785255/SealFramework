// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    products: [
        .singleTargetLibrary("Models"),

    ],
    dependencies: [
            .package(url: "https://github.com/reers/ReerCodable.git", from: "1.2.6")
    ],
    targets: [
      
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
