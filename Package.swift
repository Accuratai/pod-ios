// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AccuratSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AccuratSDK",
            targets: ["AccuratSDK"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .binaryTarget(
            name: "AccuratSDK",
            path: "./AccuratSDK.xcframework"
        )
    ]
)
