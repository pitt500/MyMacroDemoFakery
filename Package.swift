// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MyMacroDemoFakery",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MyMacroDemoFakery",
            targets: ["MyMacroDemoFakery"]
        ),
        .executable(
            name: "MyMacroDemoFakeryClient",
            targets: ["MyMacroDemoFakeryClient"]
        ),
    ],
    dependencies: [
        // Depend on the latest Swift 5.9 prerelease of SwiftSyntax
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b"),
        .package(url: "https://github.com/vadymmarkov/Fakery.git", from: "5.1.0"),
        .package(url: "https://github.com/Rightpoint/BonMot.git", from: "6.1.3"),
        .package(url: "https://github.com/yeahdongcn/UIColor-Hex-Swift.git", from: "5.1.9")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        // Macro implementation that performs the source transformation of a macro.
        .macro(
            name: "MyMacroDemoFakeryMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "Demo",
            ]
        ),

        // Library that exposes a macro as part of its API, which is used in client programs.
        .target(name: "MyMacroDemoFakery", dependencies: ["MyMacroDemoFakeryMacros"]),
        
        .target(name: "Demo", dependencies: [
            .product(name: "Fakery", package: "Fakery"),
            .product(name: "BonMot", package: "BonMot"),
            .product(name: "UIColorHexSwift", package: "UIColor-Hex-Swift")
        ]),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "MyMacroDemoFakeryClient", dependencies: [
            "MyMacroDemoFakery",
        ]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "MyMacroDemoFakeryTests",
            dependencies: [
                "MyMacroDemoFakeryMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                "Demo",
            ]
        ),
    ]
)
