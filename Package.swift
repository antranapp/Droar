// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Droar",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Droar",
            targets: ["Droar"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Droar",
            dependencies: [],
            path: "Droar/Classes",
            resources: [
                .process("Droar/Assets")
            ]
        )
    ]
)
