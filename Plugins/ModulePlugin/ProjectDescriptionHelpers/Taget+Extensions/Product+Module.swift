//
//  Product+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription


//MARK: App

public extension Product {    
    static func app(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .app
        case .Dying: return .app
        default: return .app
        }
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch product {
        case .Minimal:
            switch module {
            case .IOS: return .app
            case .Watch: return .watch2App
            case .WatchExtension: return .watch2Extension
            }
        case .Dying:
            switch module {
            case .IOS: return .app
            case .Watch: return .watch2App
            case .WatchExtension: return .watch2Extension
            }
        default:
            switch module {
            case .IOS: return .app
            case .Watch: return .watch2App
            case .WatchExtension: return .watch2Extension
            }
        }
    }
}

//MARK: Feature

public extension Product {
    static func feature(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .staticLibrary
        case .Dying: return .staticLibrary
        default: return .staticLibrary
        }
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        switch product {
        case .Minimal:
            switch module {
            default: return .staticLibrary
            }
        case .Dying:
            switch module {
            default: return .staticLibrary
            }
        default:
            switch module {
            default: return .staticLibrary
            }
        }
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> Self {
        switch type {
        case .demo: return .app
        case .interface: return .staticLibrary
        case .implement: return .staticLibrary
        case .tests: return .unitTests
        case .testing: return .staticLibrary
        }
    }
}

//MARK: Domain

public extension Product {
    static func domain(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .staticLibrary
        case .Dying: return .staticLibrary
        default: return .staticLibrary
        }
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        switch product {
        case .Minimal:
            switch module {
            default: return .staticLibrary
            }
        case .Dying:
            switch module {
            default: return .staticLibrary
            }
        default:
            switch module {
            default: return .staticLibrary
            }
        }
    }
}

//MARK: Core

public extension Product {
    static func core(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .staticLibrary
        case .Dying: return .staticLibrary
        default: return .staticLibrary
        }
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        switch product {
        case .Minimal:
            switch module {
            default: return .staticLibrary
            }
        case .Dying:
            switch module {
            default: return .staticLibrary
            }
        default:
            switch module {
            default: return .staticLibrary
            }
        }
    }
}

//MARK: Shared

public extension Product {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .staticLibrary
        case .Dying: return .staticLibrary
        default: return .staticLibrary
        }
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        switch product {
        case .Minimal:
            switch module {
            case .DesignSystem: return .staticFramework
            default: return .staticLibrary
            }
        case .Dying:
            switch module {
            case .DesignSystem: return .staticFramework
            default: return .staticLibrary
            }
        default:
            switch module {
            case .DesignSystem: return .staticFramework
            default: return .staticLibrary
            }
        }
    }
}
