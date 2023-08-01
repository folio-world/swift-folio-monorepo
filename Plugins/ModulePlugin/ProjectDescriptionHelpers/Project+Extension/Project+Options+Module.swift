//
//  Project+Options.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension Project.Options {
    static func app(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .options()
        case .Dying: return .options()
        }
    }
}

//MARK: Feature

public extension Project.Options {
    static func feature(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .options()
        case .Dying: return .options()
        }
    }
}

//MARK: Domain

public extension Project.Options {
    static func domain(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .options()
        case .Dying: return .options()
        }
    }
}

//MARK: Core

public extension Project.Options {
    static func core(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .options()
        case .Dying: return .options()
        }
    }
}

//MARK: Shared

public extension Project.Options {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        case .Minimal: return .options()
        case .Dying: return .options()
        }
    }
}
