import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", requirement: .upToNextMajor(from: "10.9.0")),
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.2.0")),
        .remote(url: "https://github.com/realm/realm-swift", requirement: .upToNextMajor(from: "10.42.2")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.15.0"))
        
    ],
    platforms: [.iOS]
)
