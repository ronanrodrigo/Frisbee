// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Frisbee",
    products: [
        .library(name: "Frisbee", targets: ["Frisbee"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Frisbee", dependencies: []),
        .testTarget(name: "FrisbeeTests", dependencies: ["Frisbee"])
    ]
)
