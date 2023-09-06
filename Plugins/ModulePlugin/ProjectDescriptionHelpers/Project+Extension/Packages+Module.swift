//
//  [Package]+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation
import ProjectDescription

//MARK: App

public extension [Package] {
    static func app(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Feature

public extension [Package] {
    static func feature(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Domain

public extension [Package] {
    static func domain(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Core

public extension [Package] {
    static func core(_ product: Module.Product) -> Self {
        return []
    }
}

//MARK: Shared

public extension [Package] {
    static func shared(_ product: Module.Product) -> Self {
        switch product {
        default: return []
        }
    }
}
