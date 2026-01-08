// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Raptor",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "Raptor", targets: ["Raptor"]),
        .library(name: "RaptorHTML", targets: ["RaptorHTML"]),
        .library(name: "RaptorVapor", targets: ["RaptorVapor"]),
        .executable(name: "RaptorCLI", targets: ["RaptorCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-markdown.git", from: "0.7.3"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.7.0"),
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.3.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.11.2"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.120.0")
    ],
    targets: [
        .target(name: "RaptorHTML"),
        .target(
            name: "Raptor",
            dependencies: [
                .byName(name: "RaptorHTML"),
                .product(name: "Markdown", package: "swift-markdown"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "SwiftSoup", package: "swiftsoup")
            ],
            resources: [
                .copy("Resources")
            ]),
        .target(
            name: "RaptorVapor",
            dependencies: [
                .byName(name: "Raptor"),
                .product(name: "Vapor", package: "vapor")
            ]),
        .executableTarget(
            name: "RaptorCLI",
            dependencies: [
                .byName(name: "Raptor"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "RaptorTesting",
            dependencies: ["Raptor", "RaptorHTML"]),
        .testTarget(
            name: "RaptorCLITesting",
            dependencies: ["RaptorCLI"])
    ]
)
