// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Terminal",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Terminal",
            targets: ["Terminal"]
        ),
    ],
    targets: [
        .target(name: "Terminal", path: "Sources")
    ]
)
