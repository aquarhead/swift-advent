// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-advent",
    platforms: [
        .macOS(.v13),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "swift-advent",
            dependencies: []),
        .testTarget(
            name: "swift-adventTests",
            dependencies: ["swift-advent"]),
    ]
)
