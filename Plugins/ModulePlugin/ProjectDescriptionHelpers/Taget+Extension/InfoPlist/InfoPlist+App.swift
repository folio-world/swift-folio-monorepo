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
    static func app(_ product: Module.Product) -> Self {
        return .default
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        return .default
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
