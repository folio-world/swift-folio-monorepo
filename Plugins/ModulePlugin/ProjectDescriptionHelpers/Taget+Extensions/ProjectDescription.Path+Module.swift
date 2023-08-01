//
//  ProjectDescription.Path+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/12.
//

import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
    static var prefix: String = "Projects"
}

// MARK: ProjectDescription.Path + App

public extension ProjectDescription.Path {
    static func app(_ product: Module.Product) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)")
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.App.name)")
    }
}

// MARK: ProjectDescription.Path + Feature

public extension ProjectDescription.Path {
    static func feature(_ product: Module.Product) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Feature.name)")
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Feature.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Domain

public extension ProjectDescription.Path {
    static func domain(_ product: Module.Product) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Domain.name)")
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Domain.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Core

public extension ProjectDescription.Path {
    static func core(_ product: Module.Product) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Core.name)")
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Core.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Shared

public extension ProjectDescription.Path {
    static func shared(_ product: Module.Product) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Shared.name)")
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        return .relativeToRoot("\(prefix)/\(product.rawValue)/\(Module.Shared.name)/\(module.rawValue)")
    }
}
