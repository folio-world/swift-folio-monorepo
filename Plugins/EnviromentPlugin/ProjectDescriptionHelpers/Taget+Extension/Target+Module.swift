//
//  Target+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension Target {
    static func app(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.app(product),
            platform: .app(product),
            product: .app(product),
            productName: .ProductName.app(product),
            bundleId: .BundleId.app(product),
            deploymentTarget: .app(product),
            infoPlist: .app(product),
            sources: .app,
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [],
            settings: .app(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        return .init(
            name: .Name.app(product, module: module),
            platform: .app(product, module: module),
            product: .app(product, module: module),
            productName: .ProductName.app(product, module: module),
            bundleId: .BundleId.app(product, module: module),
            deploymentTarget: .app(product, module: module),
            infoPlist: .app(product),
            sources: nil,
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [],
            settings: .app(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}
