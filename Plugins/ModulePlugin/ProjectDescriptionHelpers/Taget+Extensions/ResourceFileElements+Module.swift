//
//  ResourceFileElements+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/12.
//

import Foundation
import ProjectDescription

public extension ResourceFileElements {
    static func path(type: MicroTargetType) -> Self? {
        let suffix: String = "Resources/**"
        
        switch type {
        case .implement: return .init(stringLiteral: suffix)
        default: return .init(stringLiteral: type.rawValue + suffix)
        }
    }
}

//MARK: App

public extension ResourceFileElements {
    static func app(_ product: Module.Product, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
    
    static func app(_ product: Module.Product, module: Module.App, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
}

//MARK: Feature

public extension ResourceFileElements {
    static func feature(_ product: Module.Product, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
}

//MARK: Domain

public extension ResourceFileElements {
    static func domain(_ product: Module.Product, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
}

//MARK: Shared

public extension ResourceFileElements {
    static func shared(_ product: Module.Product, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
    
    static func shared(_ product: Module.Product, module: Module.Domain, type: MicroTargetType) -> Self? {
        return path(type: type)
    }
}
