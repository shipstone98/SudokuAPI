// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SudokuAPI",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "SudokuAPI", targets: ["SudokuAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.121.3")
    ],
    targets: [
        .executableTarget(
            name: "SudokuAPI",
            dependencies: [.product(name: "Vapor", package: "Vapor")]
        )
    ],
    swiftLanguageModes: [.v6]
)
