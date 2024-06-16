// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Safari",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Safari",
            targets: ["Safari"]
        ),
    ],
    targets: [
        .target(name: "Safari", path: "Sources")
    ]
)
