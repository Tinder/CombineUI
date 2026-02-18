// swift-tools-version:5.10

import Foundation
import PackageDescription

let enableSwiftLintBuildToolPlugin = ProcessInfo.processInfo.environment["CODEQL_DIST"] == nil

let package = Package(
    name: "CombineUI",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "CombineUI",
            targets: ["CombineUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/realm/SwiftLint.git",
            exact: "0.59.1"),
        .package(
            url: "https://github.com/Quick/Nimble.git",
            exact: "14.0.0"),
    ],
    targets: [
        .target(
            name: "CombineUI",
            swiftSettings: [
                .unsafeFlags(["-warnings-as-errors"], .when(configuration: .release)),
            ]),
        .testTarget(
            name: "CombineUITests",
            dependencies: [
                "CombineUI",
                "Nimble",
            ]),
    ],
)

package.targets.forEach { target in

    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
    ]

    if enableSwiftLintBuildToolPlugin {
        target.plugins = [
            .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
        ]
    }
}
