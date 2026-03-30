// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SudokuAPI",
    products: [
        .library(name: "SudokuAPI", targets: ["SudokuAPI"]),
    ],
    targets: [
        .target(name: "SudokuAPI"),
        .testTarget(name: "SudokuAPITests", dependencies: ["SudokuAPI"])
    ],
    swiftLanguageModes: [.v6]
)
