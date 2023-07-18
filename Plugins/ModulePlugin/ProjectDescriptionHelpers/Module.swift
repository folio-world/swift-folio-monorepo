//
//  Modules.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public enum MicroTargetType: String {
    case demo = "Demo"
    case interface = "Interface"
    case implement = "Implement"
    case tests = "Tests"
    case testing = "Testing"
}

public enum Module {
    case product(Product)
    case app(App)
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

// MARK: Product

public extension Module {
    enum Product: String, CaseIterable {
        case Folio
        case Dying
        
        public static let name: String = "Product"
    }
}

// MARK: App

public extension Module {
    enum App: String, CaseIterable {
        case IOS
        case Watch
        case WatchExtension
        
        public static let name: String = "App"
        
        public func dependencies(_ product: Product) -> [Module.App] {
            switch product {
            case .Folio:
                switch self {
                default: return []
                }
            case .Dying:
                switch self {
                default: return []
                }
            }
        }
    }
}


// MARK: Feature

public extension Module {
    enum Feature: String, CaseIterable {
        case Onboarding
        case Home
        
        public static let name: String = "Feature"
        
        public func dependencies(_ product: Product) -> [Module.Feature] {
            switch product {
            case .Folio:
                switch self {
                default: return []
                }
            case .Dying:
                switch self {
                default: return []
                }
            }
        }
    }
}

// MARK: Domain

public extension Module {
    enum Domain: String, CaseIterable {
        case Health
        
        public static let name: String = "Domain"
        
        public func dependencies(_ product: Product) -> [Module.Domain] {
            switch product {
            case .Folio:
                switch self {
                default: return []
                }
            case .Dying:
                switch self {
                default: return []
                }
            }
        }
    }
}

// MARK: Core

public extension Module {
    enum Core: String, CaseIterable {
        case HealthKit
        
        public static let name: String = "Core"
        
        public func dependencies(_ product: Product) -> [Module.Core] {
            switch product {
            case .Folio:
                switch self {
                default: return []
                }
            case .Dying:
                switch self {
                default: return []
                }
            }
        }
    }
}

// MARK: Shared

public extension Module {
    enum Shared: String, CaseIterable {
        case Util
        case DesignSystem
        case ThirdPartyLib
        
        public static let name: String = "Shared"
        
        public func dependencies(_ product: Product) -> [Module.Shared] {
            switch product {
            case .Folio:
                switch self {
                default: return []
                }
            case .Dying:
                switch self {
                default: return []
                }
            }
        }
    }
}

