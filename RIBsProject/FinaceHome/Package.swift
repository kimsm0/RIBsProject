// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FinaceHome",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AddPaymentMethod",
            targets: ["AddPaymentMethod"]),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "AddPaymentMethod",
        dependencies: [
            "ModernRIBs",
            "FinanceEntity",
            "FinanceRepository",
            .product(name: "RIBsUtil", package: "Platform")
        ]),
        .target(
            name: "FinanceEntity",
        dependencies: [
        ]),
        .target(
            name: "FinanceRepository",
        dependencies: [
            "FinanceEntity",
            .product(name: "CombineUtil", package: "Platform")
        ]),
    ]
)
