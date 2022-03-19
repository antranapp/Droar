// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Droar",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "Droar",
            targets: ["Droar"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/antranapp/TweakPane", .branch("master"))
    ],
    targets: [
        .target(
            name: "Droar",
            dependencies: ["TweakPane"]
        )
    ]
)
