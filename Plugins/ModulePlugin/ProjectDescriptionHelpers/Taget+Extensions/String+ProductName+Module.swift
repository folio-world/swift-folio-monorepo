//
//  String+ProductName+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public extension String {
    struct ProductName {}
}

//MARK: App

public extension String.ProductName {
    static func app(_ product: Module.Product) -> String? {
        return .Name.app(product)
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> String? {
        return nil
    }
}

//MARK: Feature

public extension String.ProductName {
    static func feature(_ product: Module.Product) -> String? {
        return nil
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> String? {
        return nil
    }
}

//MARK: Domain

public extension String.ProductName {
    static func domain(_ product: Module.Product) -> String? {
        return nil
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> String? {
        return nil
    }
}

//MARK: Core

public extension String.ProductName {
    static func core(_ product: Module.Product) -> String? {
        return nil
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> String? {
        return nil
    }
}

//MARK: Shared

public extension String.ProductName {
    static func shared(_ product: Module.Product) -> String? {
        return nil
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> String? {
        return nil
    }
}
