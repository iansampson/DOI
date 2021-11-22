// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DOI",
    products: [
        .library(
            name: "DOI",
            targets: ["DOI"]),
    ],
    targets: [
        .target(
            name: "DOI",
            dependencies: []),
        .testTarget(
            name: "DOITests",
            dependencies: ["DOI"]),
    ]
)
