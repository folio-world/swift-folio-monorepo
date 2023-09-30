//
//  Currency+Image.swift
//  ToolinderFeatureTradeDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ToolinderDomain

public extension Currency {
    var systemImageName: String {
        switch self {
        case .dollar: return "dollarsign.circle.fill"
        case .euro: return "eurosign.circle.fill"
        case .yen: return "yensign.circle.fill"
        case .sterling: return "sterlingsign.circle.fill"
        case .australianDollar: return "dollarsign.circle.fill"
        case .canadianDollar: return "dollarsign.circle.fill"
        case .franc: return "francsign.circle.fill"
        case .krona: return "dollarsign.circle.fill" // need
        case .peso: return "pesosign.circle.fill"
        case .newZealandDollar: return "dollarsign.circle.fill"
        case .singaporeDollar: return "dollarsign.circle.fill"
        case .hongKongDollar: return "dollarsign.circle.fill"
        case .krone: return "dollarsign.circle.fill" // need
        case .won: return "wonsign.circle.fill"
            
        case .bitcoin: return "bitcoinsign.circle.fill"
            
            /*
        case .florin: return "florinsign.circle.fill"
        case .turkishlira: return "turkishlirasign.circle.fill"
        case .ruble: return "rublesign.circle.fill"
        case .dong: return "dongsign.circle.fill"
        case .indianrupee: return "indianrupeesign.circle.fill"
        case .tenge: return "tengesign.circle.fill"
        case .peseta: return "pesetasign.circle.fill"
        case .kip: return "kipsign.circle.fill"
        case .austral: return "australsign.circle.fill"
        case .hryvnia: return "hryvniasign.circle.fill"
        case .naira: return "nairasign.circle.fill"
        case .guarani: return "guaranisign.circle.fill"
        case .coloncurrency: return "coloncurrencysign.circle.fill"
        case .cedi: return "cedisign.circle.fill"
        case .tugrik: return "tugriksign.circle.fill"
        case .shekel: return "shekelsign.circle.fill"
        case .manat: return "manatsign.circle.fill"
        case .baht: return "bahtsign.circle.fill"
        case .lari: return "larisign.circle.fill"
        case .brazilianreal: return "brazilianrealsign.circle.fill"
             */
        }
    }
    
    var image: Image {
        return .init(systemName: self.systemImageName)
    }
}
