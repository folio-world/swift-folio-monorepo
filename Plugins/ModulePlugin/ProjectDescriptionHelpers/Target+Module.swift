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
            sources: nil,
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [.feature(product)],
            settings: .app(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}

//MARK: Feature

public extension Target {
    static func feature(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.feature(product),
            platform: .feature(product),
            product: .feature(product),
            productName: .ProductName.feature(product),
            bundleId: .BundleId.feature(product),
            deploymentTarget: .feature(product),
            infoPlist: .feature(product),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                dependencies += Module.Feature.resolve(product).map { feature in
                        .feature(product, module: feature)
                }
                
                return dependencies
            }(),
            settings: .feature(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> Self {
        return .init(
            name: .Name.feature(product, module: module),
            platform: .feature(product, module: module),
            product: .feature(product, module: module),
            productName: .ProductName.feature(product, module: module),
            bundleId: .BundleId.feature(product, module: module),
            deploymentTarget: .feature(product, module: module),
            infoPlist: .feature(product, module: module),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                dependencies += Module.Feature.resolve(product).flatMap { feature in
                    type.dependencies().map { .feature(product, module: feature, type: $0) }
                }
                
                return dependencies
            }(),
            settings: .feature(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}

//MARK: Domain

public extension Target {
    static func domain(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.domain(product),
            platform: .domain(product),
            product: .domain(product),
            productName: .ProductName.domain(product),
            bundleId: .BundleId.domain(product),
            deploymentTarget: .domain(product),
            infoPlist: .domain(product),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [.core(product)],
            settings: .domain(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}

//MARK: Core

public extension Target {
    static func core(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.core(product),
            platform: .core(product),
            product: .core(product),
            productName: .ProductName.core(product),
            bundleId: .BundleId.core(product),
            deploymentTarget: .core(product),
            infoPlist: .core(product),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [.domain(product)],
            settings: .domain(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}

//MARK: Shared

public extension Target {
    static func shared(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.shared(product),
            platform: .shared(product),
            product: .shared(product),
            productName: .ProductName.shared(product),
            bundleId: .BundleId.shared(product),
            deploymentTarget: .shared(product),
            infoPlist: .shared(product),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: [],
            settings: .shared(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}
