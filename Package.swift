// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MCircleBoard",
    platforms: [
        .iOS("15.0")
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
            path: "Code",
            sources: ["MCircleBoard.swift"],
            resources: [
                .copy("MCircleBoard.bundle")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
