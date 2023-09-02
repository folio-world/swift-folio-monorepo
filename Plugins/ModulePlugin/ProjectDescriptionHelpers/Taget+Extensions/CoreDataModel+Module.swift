//
//  CoreDataModel.swift
//  ModulePlugin
//
//  Created by 송영모 on 2023/09/02.
//

import Foundation
import ProjectDescription

public extension CoreDataModel {
    static let trade: Self = .init(Path("Trade.xcdatamodeld"))
}

public extension [CoreDataModel] {
    static func core(_ product: Module.Product, module: Module.Core, type: MicroTargetType) -> Self {
        if product == .Toolinder && module == .LocalStorage && type == .interface {
            return [.trade]
        }
        
        return []
    }
}
