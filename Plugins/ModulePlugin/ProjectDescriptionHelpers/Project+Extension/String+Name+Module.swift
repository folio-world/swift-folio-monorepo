//
//  Project+Name.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation


//MARK: Project + Name

public extension String {
    struct Name {
        private static func product(_ product: Module.Product) -> String {
            switch product {
            case .Minimal: return "Folio"
            case .Dying: return "Dying"
            case .Mulling: return "Mulling"
            case .Toolinder: return "Toolinder"
            case .Folio: return "Folio"
            }
        }
    }
}


//MARK: App

public extension String.Name {
    static func app(_ product: Module.Product) -> String {
        return self.product(product)
    }
    
    static func app(_ product: Module.Product, module: Module.App) -> String {
        return self.product(product) + module.rawValue
    }
}

//MARK: Feature

public extension String.Name {
    static func feature(_ prodct: Module.Product) -> String {
        return self.product(prodct) + Module.Feature.name
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature) -> String {
        return self.product(product) + Module.Feature.name + module.rawValue
    }
    
    static func feature(_ product: Module.Product, module: Module.Feature, type: MicroTargetType) -> String {
        return self.product(product) + Module.Feature.name + module.rawValue + type.rawValue
    }
}

//MARK: Domain

public extension String.Name {
    static func domain(_ prodct: Module.Product) -> String {
        return self.product(prodct) + Module.Domain.name
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain) -> String {
        return self.product(product) + Module.Domain.name + module.rawValue
    }
    
    static func domain(_ product: Module.Product, module: Module.Domain, type: MicroTargetType) -> String {
        return self.product(product) + Module.Domain.name + module.rawValue + type.rawValue
    }
}

//MARK: Core

public extension String.Name {
    static func core(_ prodct: Module.Product) -> String {
        return self.product(prodct) + Module.Core.name
    }
    
    static func core(_ product: Module.Product, module: Module.Core) -> String {
        return self.product(product) + Module.Core.name + module.rawValue
    }
    
    static func core(_ product: Module.Product, module: Module.Core, type: MicroTargetType) -> String {
        return self.product(product) + Module.Core.name + module.rawValue + type.rawValue
    }
}

//MARK: Shared

public extension String.Name {
    static func shared(_ prodct: Module.Product) -> String {
        return self.product(prodct) + Module.Shared.name
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared) -> String {
        return self.product(product) + Module.Shared.name + module.rawValue
    }
    
    static func shared(_ product: Module.Product, module: Module.Shared, type: MicroTargetType) -> String {
        return self.product(product) + Module.Shared.name + module.rawValue + type.rawValue
    }
}
