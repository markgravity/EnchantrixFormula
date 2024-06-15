// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SystemEvents",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "SystemEvents",
            targets: ["SystemEvents"]
        ),
    ],
    targets: [
        .target(name: "SystemEvents", path: "Sources")
    ]
)
