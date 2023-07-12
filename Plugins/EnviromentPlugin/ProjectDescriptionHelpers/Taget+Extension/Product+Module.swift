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
        case .Dying: return .app
        }
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch product {
        case .Dying:
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
        case .Dying: return .staticLibrary
        }
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Onboarding: return .staticLibrary
            }
        }
    }
}

//MARK: Domain

public extension Product {
    static func domain(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .staticLibrary
        }
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Health: return .staticLibrary
            }
        }
    }
}

//MARK: Core

public extension Product {
    static func core(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .staticLibrary
        }
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .HealthKit: return .staticLibrary
            }
        }
    }
}

//MARK: Shared

public extension Product {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .staticLibrary
        }
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Util: return .staticLibrary
            case .DesignSystem: return .staticFramework
            case .ThirdPartyLib: return .staticLibrary
            }
        }
    }
}
