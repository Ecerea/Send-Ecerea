// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "EcereaVapor",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),        
        //Alamofire
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Alamofire"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

