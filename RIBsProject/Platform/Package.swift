// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "PlatformTestSupport",
            targets: ["PlatformTestSupport"]),
        .library(
            name: "CombineUtil",
            targets: ["CombineUtil"]),
        .library(
            name: "RIBsUtil",
            targets: ["RIBsUtil"]),
        .library(
            name: "SuperUI",
            targets: ["SuperUI"]),
        .library(
            name: "Utils",
            targets: ["Utils"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "NetworkImp",
            targets: ["NetworkImp"]),
        .library(
            name: "DefaultsStore",
            targets: ["DefaultsStore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: .init(1, 0, 0)),
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: .init(1, 0, 0)),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: .init(1, 12, 0)),
        .package(url: "https://github.com/httpswift/swifter.git", from: .init(1, 5, 0)),
    ],
    targets: [
        .target(
            name: "CombineUtil",
            dependencies: [
                "CombineExt",
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]
        ),
        .target(
            name: "RIBsUtil",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "SuperUI",
            dependencies: [ 
                "RIBsUtil"
            ]
        ),
        .target(
            name: "Utils",
            dependencies: [
                
            ]
        ),
        .target(
            name: "Network",
            dependencies: [
                
            ]
        ),
        .target(
            name: "NetworkImp",
            dependencies: [
                "Network"
            ]
        ),
        .target(
            name: "DefaultsStore",
            dependencies: [
                
            ]
        ),
        .target(
            name: "PlatformTestSupport",
            dependencies: [
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
                .product(name: "Swifter", package: "swifter"),                
            ]
        ),
    ]
)
