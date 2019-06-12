// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "RxRouting",
    products: [
        .library(name: "RxRouting", targets: ["RxRouting", "RxRoutingTests"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "8.0.1"))
    ],
    targets: [
        .target(
            name: "RxRouting",
            dependencies: [
                "RxSwift"

            ],
            path: "Sources",
            exclude: [ "Example", "RxRoutingTests" ]
        ),
        .testTarget(
            name: "RxRoutingTests",
            dependencies: [
                "RxSwift",
                "Nimble"

            ],
            path: "RxRoutingTests"
        )
    ]
)
