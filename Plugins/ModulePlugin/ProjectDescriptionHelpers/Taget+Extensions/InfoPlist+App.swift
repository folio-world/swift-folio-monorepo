//
//  InfoPlist+App.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/11.
//

import Foundation
import ProjectDescription

//MARK: App

public extension InfoPlist {
    static var prefixPath: String = "Support"
    
    static func app(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        return .file(path: "\(prefixPath)/\(String.Name.app(product))\(Module.App.name)\(module.rawValue)-Info.plist")
    }
}

//MARK: Feature

public extension InfoPlist {
    static func feature(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        return .default
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> Self {
        switch type {
        case .demo: return .file(path: "\(prefixPath)/\(String.Name.feature(product, module: module, type: type))-Info.plist")
        default: return .feature(product, module: module)
        }
    }
}

//MARK: Domain

public extension InfoPlist {
    static func domain(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        return .default
    }
}

//MARK: Core

public extension InfoPlist {
    static func core(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        return .default
    }
}

//MARK: Shared

public extension InfoPlist {
    static func shared(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        return .default
    }
}
