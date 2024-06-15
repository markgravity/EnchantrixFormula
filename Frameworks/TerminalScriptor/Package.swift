// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Terminal",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "TerminalScriptor",
            targets: ["TerminalScriptor"]
        ),
    ],
    targets: [
        .target(name: "TerminalScriptor", path: "Sources")
    ]
)
