//
//  Project+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/12.
//

import Foundation
import ProjectDescription

//MARK: App

public extension Project {
    static func app(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.app(product),
            organizationName: .OrganizationName(product),
            options: .app(product),
            packages: .app(product),
            settings: .app(product),
            targets: {
                var targets: [Target] = []
                
                targets += Module.App.targets(product).map { app in
                    return .app(product, module: app)
                }
                
                return targets
            }(),
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: [])
    }
}

//MARK: Feature

public extension Project {
    static func feature(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.feature(product),
            organizationName: nil,
            options: .feature(product),
            packages: .feature(product),
            settings: .feature(product),
            targets: [.feature(product)],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> Self {
        return .init(
            name: .Name.feature(product, module: module),
            organizationName: nil,
            options: .feature(product),
            packages: .feature(product),
            settings: .feature(product),
            targets: {
                var targets: [Target] = []
                
                targets += [
                    .feature(product, module: module, type: .interface),
                    .feature(product, module: module, type: .implement),
                    .feature(product, module: module, type: .demo),
                    .feature(product, module: module, type: .tests),
                    .feature(product, module: module, type: .testing)
                ]
                
                return targets
            }(),
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
}

//MARK: Domain

public extension Project {
    static func domain(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.domain(product),
            organizationName: nil,
            options: .domain(product),
            packages: .domain(product),
            settings: .domain(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> Self {
        return .init(
            name: .Name.domain(product, module: module),
            organizationName: nil,
            options: .domain(product),
            packages: .domain(product),
            settings: .domain(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
}

//MARK: Core

public extension Project {
    static func core(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.core(product),
            organizationName: nil,
            options: .core(product),
            packages: .core(product),
            settings: .core(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> Self {
        return .init(
            name: .Name.core(product, module: module),
            organizationName: nil,
            options: .core(product),
            packages: .core(product),
            settings: .core(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
}

//MARK: Shared

public extension Project {
    static func shared(_ product: Module.Product) -> Self {
        return .init(
            name: .Name.shared(product),
            organizationName: nil,
            options: .shared(product),
            packages: .shared(product),
            settings: .shared(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> Self {
        return .init(
            name: .Name.shared(product, module: module),
            organizationName: nil,
            options: .shared(product),
            packages: .shared(product),
            settings: .shared(product),
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
}
