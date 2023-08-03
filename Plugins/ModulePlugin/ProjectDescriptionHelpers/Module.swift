//
//  Modules.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public enum MicroTargetType: String, CaseIterable {
    case demo = "Demo"
    case interface = "Interface"
    case implement = ""
    case tests = "Tests"
    case testing = "Testing"
    
    public func dependencies() -> [MicroTargetType] {
        switch self {
        case .demo: return [.implement, .interface]
        case .interface: return []
        case .implement: return [.interface]
        case .tests: return [.testing]
        case .testing: return [.interface]
        }
    }
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
        case Minimal
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
        
        public static func targets(_ product: Product) -> [Module.App] {
            switch product {
            case .Minimal:
                switch self {
                default: return [.IOS]
                }
            case .Dying:
                switch self {
                default: return [.IOS]
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
        case MyPage
        
        public static let name: String = "Feature"
        
        public static func targets(_ product: Product) -> [Module.Feature] {
            switch product {
            case .Minimal: return []
            case .Dying: return [.Onboarding, .Home, .MyPage]
            }
        }
        
        public func microTargetTypes(_ product: Product) -> [MicroTargetType] {
            switch product {
            case .Minimal:
                switch self {
                default: return MicroTargetType.allCases
                }
            case .Dying:
                switch self {
                default: return MicroTargetType.allCases
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
        
        public static func targets(_ product: Product) -> [Module.Domain] {
            switch product {
            case .Minimal: return []
            case .Dying: return [.Health]
            }
        }
        
        public func microTargetTypes(_ product: Product) -> [MicroTargetType] {
            switch product {
            case .Minimal:
                switch self {
                default: return MicroTargetType.allCases
                }
            case .Dying:
                switch self {
                default: return [.implement, .interface, .testing, .tests]
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
        
        public static func targets(_ product: Product) -> [Module.Core] {
            switch product {
            case .Minimal: return [.HealthKit]
            case .Dying: return []
            }
        }
        
        public func microTargetTypes(_ product: Product) -> [MicroTargetType] {
            switch product {
            case .Minimal:
                switch self {
                default: return MicroTargetType.allCases
                }
            case .Dying:
                switch self {
                default: return [.implement, .interface, .testing, .tests]
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
        
        public static func targets(_ product: Product) -> [Module.Shared] {
            switch product {
            case .Minimal: return [.Util, .DesignSystem]
            case .Dying: return [.Util, .DesignSystem, .ThirdPartyLib]
            }
        }
        
        public func microTargetTypes(_ product: Product) -> [MicroTargetType] {
            switch product {
            case .Minimal:
                switch self {
                default: return [.implement, .interface]
                }
            case .Dying:
                switch self {
                default: return [.implement, .interface]
                }
            }
        }
    }
}

