// swift-tools-version:5.9

import PackageDescription

let packageName = "CombineUI"

enum SwiftLint {
    static let plugin = "SwiftLintPlugin-\(packageName)"
    static let binary = "SwiftLintBinary-\(packageName)"
}

let package = Package(
    name: packageName,
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CombineUI",
            targets: ["CombineUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble.git",
            from: "13.0.0"),
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
            url: "https://github.com/realm/SwiftLint/releases/download/0.54.0/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "963121d6babf2bf5fd66a21ac9297e86d855cbc9d28322790646b88dceca00f1"),
    ]
)
