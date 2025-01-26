// swift-tools-version:5.8

import PackageDescription

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
            exact: "0.56.2"),
        .package(
            url: "https://github.com/Quick/Nimble.git",
            exact: "13.4.0"),
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
    ]
)

package.targets.forEach { target in

    target.swiftSettings = [
        .enableExperimentalFeature("StrictConcurrency"),
    ]

    target.plugins = [
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
    ]
}
