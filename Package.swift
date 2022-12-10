// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-advent",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "swift-advent",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]),
    ]
)
