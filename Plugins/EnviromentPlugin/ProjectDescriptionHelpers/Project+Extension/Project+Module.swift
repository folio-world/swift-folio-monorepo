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
            targets: [],
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
            targets: [],
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
            targets: [],
            schemes: [],
            fileHeaderTemplate: nil,
            additionalFiles: [],
            resourceSynthesizers: []
        )
    }
}
