// swift-tools-version:5.8

import PackageDescription

let packageName = "CombineUI"

enum SwiftLint {
    static let plugin = "SwiftLintPlugin-\(packageName)"
    static let binary = "SwiftLintBinary-\(packageName)"
}

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CombineUI",
            targets: ["CombineUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble.git",
            from: "12.0.0"),
    ],
    targets: [
        .target(
            name: "CombineUI",
            swiftSettings: [
                .unsafeFlags(["-strict-concurrency=complete"]),
            ],
            plugins: [
                .plugin(name: SwiftLint.plugin),
            ]),
        .testTarget(
            name: "CombineUITests",
            dependencies: [
                "CombineUI",
                "Nimble",
            ],
            plugins: [
                .plugin(name: SwiftLint.plugin),
            ]),
        .plugin(
            name: SwiftLint.plugin,
            capability: .buildTool(),
            dependencies: [
                .target(name: SwiftLint.binary)
            ],
            path: "Plugins/SwiftLintPlugin"),
        .binaryTarget(
            name: SwiftLint.binary,
            url: "https://github.com/realm/SwiftLint/releases/download/0.52.4/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "8a8095e6235a07d00f34a9e500e7568b359f6f66a249f36d12cd846017a8c6f5"),
    ]
)
