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
            name: "AddPaymentMethodImp",
            targets: ["AddPaymentMethodImp"]),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),
        .library(
            name: "Topup",
            targets: ["Topup"]),
        .library(
            name: "TopupImp",
            targets: ["TopupImp"]),
        .library(
            name: "Finance",
            targets: ["Finance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: .init(5, 7, 1)),
        .package(path: "../Platform")
    ],
    targets: [
        .target(
            name: "AddPaymentMethodImp",
        dependencies: [
            "ModernRIBs",
            "FinanceEntity",
            "FinanceRepository",
            "SnapKit",
            "AddPaymentMethod",
            .product(name: "RIBsUtil", package: "Platform"),
            .product(name: "SuperUI", package: "Platform")
        ]),
        .target(
            name: "FinanceEntity",
        dependencies: [
            .product(name: "SuperUI", package: "Platform")
        ]),
        .target(
            name: "FinanceRepository",
        dependencies: [
            "FinanceEntity",
            .product(name: "CombineUtil", package: "Platform"),
            .product(name: "Network", package: "Platform")
        ]),
        .target(
            name: "Topup",
        dependencies: [
            "ModernRIBs",
            "FinanceEntity",
            "FinanceRepository",
            "SnapKit",
            "AddPaymentMethodImp",
            .product(name: "RIBsUtil", package: "Platform"),
            .product(name: "SuperUI", package: "Platform"),
            .product(name: "Utils", package: "Platform"),
            .product(name: "Network", package: "Platform")
        ]),
        .target(
            name: "Finance",
        dependencies: [
            "ModernRIBs",
            "FinanceEntity",
            "FinanceRepository",
            "SnapKit",
            "AddPaymentMethodImp",
            "AddPaymentMethod",
            "TopupImp",
            "Topup",
        ]),
        .target(
            name: "TopupImp",
        dependencies: [ 
            "Topup",
        ]),
        .target(
            name: "AddPaymentMethod",
        dependencies: [
            "ModernRIBs",
            "FinanceEntity",
            .product(name: "RIBsUtil", package: "Platform"),
        ]),
    ]
)
