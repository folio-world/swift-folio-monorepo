//
//  [Package]+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension [Package] {
    static func app(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Feature

public extension [Package] {
    static func feature(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Domain

public extension [Package] {
    static func domain(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Core

public extension [Package] {
    static func core(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Shared

public extension [Package] {
    static func shared(_ product: Module.Product) -> Self {
        return [
//            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.0.0")),
//            .remote(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads", requirement: .upToNextMajor(from: "10.9.0"))
        ]
    }
}
