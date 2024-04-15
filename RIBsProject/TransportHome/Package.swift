// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TransportHome",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Transport",
            targets: ["Transport"]),
        .library(
            name: "TransportImp",
            targets: ["TransportImp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),                
        .package(path: "../FinaceHome"),
        .package(path: "../Platform"),
    ],
    targets: [
        .target(
            name: "TransportImp",
        dependencies: [
            "ModernRIBs",
            "Transport",
            .product(name: "FinanceRepository", package: "FinaceHome"),
            .product(name: "Utils", package: "Platform"),
        ],
        resources: [
            .process("Resources")
        ]),
        .target(
            name: "Transport",
        dependencies: [
            "ModernRIBs",
        ],
        resources: [
            
        ]),
    ]
)
