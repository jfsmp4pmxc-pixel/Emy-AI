// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EmptyStudioAI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .iOSApplication(
            name: "EmptyStudioAI",
            targets: ["EmptyStudioAI"],
            bundleIdentifier: "com.emptystudio.EmptyStudioAI",
            displayVersion: "1.0.0",
            bundleVersion: "1",
            supportedInterfaceOrientations: [
                .portrait
            ]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "EmptyStudioAI",
            dependencies: [],
            path: "EmptyStudioAI",
            resources: [
                .copy("EmyEngine.py") // Đảm bảo file Python được đóng gói vào App Bundle
            ]
        )
    ]
)
