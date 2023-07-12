//
//  Platform+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension Platform {
    static func app(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .IOS: return .iOS
            case .Watch: return .watchOS
            case .WatchExtension: return .watchOS
            }
        }
    }
}

//MARK: Feature

public extension Platform {
    static func feature(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
}

//MARK: Domain

public extension Platform {
    static func domain(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
}

//MARK: Core

public extension Platform {
    static func core(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
}

//MARK: Shared

public extension Platform {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        switch product {
        case .Dying: return .iOS
        }
    }
}
