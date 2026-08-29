// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MenuPet",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "MenuPet",
            path: "Sources/MenuPet"
        )
    ]
)
