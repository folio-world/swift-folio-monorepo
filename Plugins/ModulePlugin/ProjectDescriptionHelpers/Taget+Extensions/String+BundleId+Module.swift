//
//  String+BundleId+Module.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

public extension String {
    struct BundleId {
        private static func prefix(_ product: Module.Product) -> String {
            let prefix: String = "com." + .OrganizationName(product) + .Name.app(product)
            
            return prefix.lowercased()
        }
    }
}

//MARK: App

public extension String.BundleId {
    static func app(_ product: Module.Product) -> String {
        let id = self.prefix(product) + "." + Module.App.name
        
        return id.lowercased()
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> String {
        let id = self.prefix(product) + "." + Module.App.name + "." + module.rawValue
        
        return id.lowercased()
    }
}

//MARK: Feature

public extension String.BundleId {
    static func feature(_ product: Module.Product) -> String {
        let id = self.prefix(product) + "." + Module.Feature.name
        
        return id.lowercased()
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> String {
        let id = self.prefix(product) + "." + Module.Feature.name + "." + module.rawValue
        
        return id.lowercased()
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> String {
        let id = self.prefix(product) + "." + Module.Feature.name + "." + module.rawValue + "." + type.rawValue
        
        return id.lowercased()
    }
}

//MARK: Domain

public extension String.BundleId {
    static func domain(_ product: Module.Product) -> String {
        let id = self.prefix(product) + "." + Module.Domain.name
        
        return id.lowercased()
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> String {
        let id = self.prefix(product) + "." + Module.Domain.name + "." + module.rawValue
        
        return id.lowercased()
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain, type: MicroTargetType) -> String {
        let id = self.prefix(product) + "." + Module.Domain.name + "." + module.rawValue + "." + type.rawValue
        
        return id.lowercased()
    }
}

//MARK: Core

public extension String.BundleId {
    static func core(_ product: Module.Product) -> String {
        let id = self.prefix(product) + "." + Module.Core.name
        
        return id.lowercased()
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> String {
        let id = self.prefix(product) + "." + Module.Core.name + "." + module.rawValue
        
        return id.lowercased()
    }
    
    static func core(_ product: Module.Product, module: Module.Core, type: MicroTargetType) -> String {
        let id = self.prefix(product) + "." + Module.Core.name + "." + module.rawValue + "." + type.rawValue
        
        return id.lowercased()
    }
}

//MARK: Shared

public extension String.BundleId {
    static func shared(_ product: Module.Product) -> String {
        let id = self.prefix(product) + "." + Module.Shared.name
        
        return id.lowercased()
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> String {
        let id = self.prefix(product) + "." + Module.Shared.name + "." + module.rawValue
        
        return id.lowercased()
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared, type: MicroTargetType) -> String {
        let id = self.prefix(product) + "." + Module.Shared.name + "." + module.rawValue + "." + type.rawValue
        
        return id.lowercased()
    }
}
