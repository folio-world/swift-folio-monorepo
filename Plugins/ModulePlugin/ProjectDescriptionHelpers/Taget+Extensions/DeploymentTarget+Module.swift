//
//  DeploymentTarget+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

public extension DeploymentTarget {
    private static func iOS(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .iOS(targetVersion: "16.0", devices: [.iphone])
        case .Dying: return .iOS(targetVersion: "16.0", devices: [.iphone])
        }
    }
    
    private static func watchOS(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .watchOS(targetVersion: "9.0")
        case .Dying: return .watchOS(targetVersion: "9.0")
        }
    }
    
    private static func resolve(_ product: Module.Product, platform: Platform) -> Self? {
        switch platform {
        case .iOS: return .iOS(product)
        case .macOS: return nil
        case .watchOS: return .watchOS(product)
        case .tvOS: return nil
        @unknown default: return nil
        }
    }
}

//MARK: App

public extension DeploymentTarget {
    static func app(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .iOS(product)
        case .Dying: return .iOS(product)
        }
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch product {
        case .Minimal:
            switch module {
            case .IOS: return .iOS(product)
            case .Watch: return .watchOS(product)
            case .WatchExtension: return .watchOS(product)
            }
        case .Dying:
            switch module {
            case .IOS: return .iOS(product)
            case .Watch: return .watchOS(product)
            case .WatchExtension: return .watchOS(product)
            }
        }
    }
}

//MARK: Feature

public extension DeploymentTarget {
    static func feature(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .feature(product))
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self? {
        return resolve(product, platform: .feature(product, module: module))
    }
}

//MARK: Domain

public extension DeploymentTarget {
    static func domain(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .domain(product))
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self? {
        return resolve(product, platform: .domain(product, module: module))
    }
}

//MARK: Core

public extension DeploymentTarget {
    static func core(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .core(product))
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self? {
        return resolve(product, platform: .core(product, module: module))
    }
}

//MARK: Shared

public extension DeploymentTarget {
    static func shared(_ product: Module.Product) -> Self? {
        return resolve(product, platform: .shared(product))
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self? {
        return resolve(product, platform: .shared(product, module: module))
    }
}
