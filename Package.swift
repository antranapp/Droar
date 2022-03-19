// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Droar",
    platforms: [
        .iOS(.v11),
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
            dependencies: [
                "ObjcHelper"
            ],
            path: "Droar/Classes",
            resources: [
                .process("Droar/Assets")
            ]
        ),
        .target(
            name: "ObjcHelper",
            dependencies: [],
            path: "Droar/ObjcHelper"
        ),
    ]
)
