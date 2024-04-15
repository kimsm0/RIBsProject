// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileHome",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Profile",
            targets: ["Profile"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/ModernRIBs", from: .init(1, 0, 1)),
    ],
    targets: [
        .target(
            name: "Profile",
        dependencies: [
            "ModernRIBs"
        ]),
    ]
)
