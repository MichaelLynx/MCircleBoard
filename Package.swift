// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "MCircleBoard",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MCircleBoard",
            targets: ["MCircleBoard"]
        )
    ],
    targets: [
        .target(
            name: "MCircleBoard",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "MCircleBoardTests",
            dependencies: ["MCircleBoard"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
