//
//  String+Organization.swift
//  EnviromentPlugin
//
//  Created by 송영모 on 2023/07/06.
//

import Foundation

//MARK: String + OrganizationName

public extension String {
    static func OrganizationName(_ product: Module.Product) -> Self {
        switch product {
        case .Dying: return "folio.world"
        }
    }
}
