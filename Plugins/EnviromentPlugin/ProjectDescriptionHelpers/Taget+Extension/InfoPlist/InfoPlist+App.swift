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
        switch product {
        case .Dying: return .default
        }
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .IOS: return .default
            case .Watch: return .default
            case .WatchExtension: return .default
            }
        }
    }
}

//MARK: Feature

public extension InfoPlist {
    static func feature(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .default
        }
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Workout: return .default
            case .Onboarding: return .default
            case .Home: return .default
            case .Profile: return .default
            }
        }
    }
}

//MARK: Domain

public extension InfoPlist {
    static func domain(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .default
        }
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Workout: return .default
            case .Auth: return .default
            case .Health: return .default
            }
        }
    }
}

//MARK: Core

public extension InfoPlist {
    static func core(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .default
        }
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .HealthKitManager: return .default
            case .KeyChainStore: return .default
            case .Network: return .default
            }
        }
    }
}

//MARK: Shared

public extension InfoPlist {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return .default
        }
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        switch product {
        case .Dying:
            switch module {
            case .Util: return .default
            case .DesignSystem: return .default
            case .ThirdPartyLib: return .default
            }
        }
    }
}
