//
//  Modules.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public enum MicroTargetType: String {
    case interface = "Interface"
    case implement = "Implement"
    case tests = "Tests"
    case testing = "Testing"
}

public enum Module {
    case product(Product)
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

// MARK: ProductModule

public extension Module {
    enum Product: String, CaseIterable {
        case Dying
        
        public static let name: String = "Product"
    }
}

// MARK: AppModule

public extension Module {
    enum App: String, CaseIterable {
        case IOS
        case Watch
        case WatchExtension
        
        public static let name: String = "App"
    }
}


// MARK: FeatureModule

public extension Module {
    enum Feature: String, CaseIterable {
        case Onboarding
        
        public static let name: String = "Feature"
    }
}

// MARK: DomainModule

public extension Module {
    enum Domain: String, CaseIterable {
        case Health
        
        public static let name: String = "Domain"
    }
}

// MARK: CoreModule

public extension Module {
    enum Core: String, CaseIterable {
        case HealthKit
        
        public static let name: String = "Core"
    }
}

// MARK: SharedModule

public extension Module {
    enum Shared: String, CaseIterable {
        case Util
        case DesignSystem
        case ThirdPartyLib
        
        public static let name: String = "Shared"
    }
}

