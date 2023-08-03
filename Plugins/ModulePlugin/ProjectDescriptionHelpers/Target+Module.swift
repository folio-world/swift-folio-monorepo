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
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = [
                    .feature(product)
                ]
                
                dependencies += Module.App.targets(product).map { app in
                        .app(product, module: app)
                }
                
                return dependencies
            }(),
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
            infoPlist: .app(product, module: module),
            sources: .path(type: .implement),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = [
                    .feature(product)
                ]
                
                return dependencies
            }(),
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
                
                dependencies += Module.Feature.targets(product).map { feature in
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
            name: .Name.feature(product, module: module, type: type),
            platform: .feature(product, module: module),
            product: .feature(product, module: module, type: type),
            productName: .ProductName.feature(product, module: module),
            bundleId: .BundleId.feature(product, module: module),
            deploymentTarget: .feature(product, module: module),
            infoPlist: .feature(product, module: module, type: type),
            sources: .path(type: type),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                if type == .interface {
                    dependencies += [.domain(product)]
                }
                
                dependencies += type.dependencies().map {
                    .feature(product, module: module, type: $0)
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
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                dependencies += Module.Domain.targets(product).map { domain in
                        .domain(product, module: domain)
                }
                
                return dependencies
            }(),
            settings: .domain(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain, type: MicroTargetType) -> Self {
        return .init(
            name: .Name.domain(product, module: module, type: type),
            platform: .domain(product, module: module),
            product: .domain(product, module: module),
            productName: .ProductName.domain(product, module: module),
            bundleId: .BundleId.domain(product, module: module),
            deploymentTarget: .domain(product, module: module),
            infoPlist: .domain(product, module: module),
            sources: .path(type: type),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                if type == .interface {
                    dependencies += [.core(product)]
                }
                
                dependencies += type.dependencies().map {
                    .domain(product, module: module, type: $0)
                }
                
                return dependencies
            }(),
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
            dependencies: {
                var dependencies: [TargetDependency] = [.shared(product)]
                
                dependencies += Module.Core.targets(product).map { core in
                        .core(product, module: core)
                }
                
                return dependencies
            }(),
            settings: .core(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
    
    static func core(_ product: Module.Product, module: Module.Core, type: MicroTargetType) -> Self {
        return .init(
            name: .Name.core(product, module: module, type: type),
            platform: .core(product, module: module),
            product: .core(product, module: module),
            productName: .ProductName.core(product, module: module),
            bundleId: .BundleId.core(product, module: module),
            deploymentTarget: .core(product, module: module),
            infoPlist: .core(product, module: module),
            sources: .path(type: type),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []

                if type == .interface {
                    dependencies += [.shared(product)]
                }
                
                dependencies += type.dependencies().map {
                    .core(product, module: module, type: $0)
                }
                
                return dependencies
            }(),
            settings: .core(product),
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
            dependencies: {
                var dependencies: [TargetDependency] = []
                
                dependencies += Module.Shared.targets(product).map { shared in
                        .shared(product, module: shared)
                }
                
                return dependencies
            }(),
            settings: .shared(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared, type: MicroTargetType) -> Self {
        return .init(
            name: .Name.shared(product, module: module, type: type),
            platform: .shared(product, module: module),
            product: .shared(product, module: module),
            productName: .ProductName.shared(product, module: module),
            bundleId: .BundleId.shared(product, module: module),
            deploymentTarget: .shared(product, module: module),
            infoPlist: .shared(product, module: module),
            sources: .path(type: type),
            resources: nil,
            copyFiles: nil,
            headers: nil,
            entitlements: nil,
            scripts: [],
            dependencies: {
                var dependencies: [TargetDependency] = []

                dependencies += type.dependencies().map {
                    .shared(product, module: module, type: $0)
                }
                
                if module == .ThirdPartyLib && type == .interface {
                    dependencies += .thirdPartyLibs(product)
                }
                
                return dependencies
            }(),
            settings: .shared(product),
            coreDataModels: [],
            environment: [:],
            launchArguments: [],
            additionalFiles: [],
            buildRules: [])
    }
}
