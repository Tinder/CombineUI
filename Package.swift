// swift-tools-version:5.10

import Foundation
import PackageDescription

let environment = ProcessInfo.processInfo.environment

let treatWarningsAsErrors = environment["CI"] == "true"
let enableSwiftLintBuildToolPlugin = environment["CODEQL_DIST"] == nil

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
            name: "CombineUI"),
        .testTarget(
            name: "CombineUITests",
            dependencies: [
                "CombineUI",
                "Nimble",
            ]),
    ],
)

package.targets.forEach { target in

    // TODO: Remove upon enabling Swift 6 language mode:
    target.swiftSettings = (target.swiftSettings ?? []) + [.enableExperimentalFeature("StrictConcurrency")]

    if treatWarningsAsErrors {
        target.swiftSettings = (target.swiftSettings ?? []) + [
            // TODO: Remove unsafe flag upon upgrading to Swift tools v6.2 and uncomment subsequent settings:
            .unsafeFlags(["-warnings-as-errors"]),
//            .treatAllWarnings(as: .error),
//            .treatWarning("DeprecatedDeclaration", as: .warning)
        ]
    }

    if enableSwiftLintBuildToolPlugin {
        target.plugins = (target.plugins ?? []) + [
            .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
        ]
    }
}
