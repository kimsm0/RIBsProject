// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CX",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AppHome",
            targets: ["AppHome"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(path: "../FinaceHome"),
        .package(path: "../TransportHome"),
    ],
    targets: [
        .target(
            name: "AppHome",
        dependencies: [
            "ModernRIBs",
            .product(name: "FinanceRepository", package: "FinaceHome"),
            .product(name: "Transport", package: "TransportHome"),
        ]),
    ]
)
