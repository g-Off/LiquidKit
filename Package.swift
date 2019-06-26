// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "LiquidKit",
	platforms: [
		.macOS(.v10_14),
		.iOS(.v11)
	],
    products: [
        .library(
            name: "LiquidKit",
            targets: ["LiquidKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "LiquidKit",
            dependencies: []),
        .testTarget(
            name: "LiquidKitTests",
            dependencies: ["LiquidKit"]),
    ]
)
