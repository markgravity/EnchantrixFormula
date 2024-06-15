// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Finder",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "Finder",
            targets: ["Finder"]
        ),
    ],
    targets: [
        .target(name: "Finder", path: "Sources")
    ]
)
