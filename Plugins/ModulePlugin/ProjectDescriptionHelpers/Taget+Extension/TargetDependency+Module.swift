//
//  [TargetDependency]+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/12.
//

import Foundation
import ProjectDescription

// MARK: App

public extension TargetDependency {
    static func app(_ product: Module.Product) -> Self {
        return .project(target: Module.Product.name + Module.App.name, path: .app(product))
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        return .project(target: Module.Product.name + Module.App.name + module.rawValue, path: .app(product, module: module))
    }
}

// MARK: Feature

public extension TargetDependency {
    static func feature(_ product: Module.Product) -> Self {
        return .project(target: Module.Product.name + Module.Feature.name, path: .feature(product))
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        return .project(target: Module.Product.name + Module.Feature.name + module.rawValue, path: .feature(product, module: module))
    }
    
    static func feature(
        _ product: Module.Product,
        module: Module.Feature,
        type: MicroTargetType) -> Self {
        return .project(
            target: Module.Product.name + Module.Feature.name + module.rawValue + type.rawValue,
            path: .feature(product, module: module))
    }
}

// MARK: Domain

public extension TargetDependency {
    static func domain(_ product: Module.Product) -> Self {
        return .project(target: Module.Product.name + Module.Domain.name, path: .domain(product))
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        return .project(target: Module.Product.name + Module.Domain.name + module.rawValue, path: .domain(product, module: module))
    }
    
    static func domain(
        _ product: Module.Product,
        module: Module.Domain,
        type: MicroTargetType) -> Self {
        return .project(
            target: Module.Product.name + Module.Domain.name + module.rawValue + type.rawValue,
            path: .domain(product, module: module))
    }
}

// MARK: Core

public extension TargetDependency {
    static func core(_ product: Module.Product) -> Self {
        return .project(target: Module.Product.name + Module.Core.name, path: .core(product))
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        return .project(target: Module.Product.name + Module.Core.name + module.rawValue, path: .core(product, module: module))
    }
    
    static func core(
        _ product: Module.Product,
        module: Module.Core,
        type: MicroTargetType) -> Self {
        return .project(
            target: Module.Product.name + Module.Core.name + module.rawValue + type.rawValue,
            path: .core(product, module: module))
    }
}

// MARK: Shared

public extension TargetDependency {
    static func shared(_ product: Module.Product) -> Self {
        return .project(target: Module.Product.name + Module.Shared.name, path: .shared(product))
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        return .project(target: Module.Product.name + Module.Shared.name + module.rawValue, path: .shared(product, module: module))
    }
    
    static func shared(
        _ product: Module.Product,
        module: Module.Shared,
        type: MicroTargetType) -> Self {
        return .project(
            target: Module.Product.name + Module.Shared.name + module.rawValue + type.rawValue,
            path: .shared(product, module: module))
    }
}
