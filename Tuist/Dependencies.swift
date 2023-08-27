import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", requirement: .upToNextMajor(from: "10.9.0"))
    ],
    platforms: [.iOS]
)
