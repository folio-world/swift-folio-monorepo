//
//  TickerType+Image.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation
import SwiftUI

import ToolinderDomain

extension TickerType {
    var systemImageName: String {
        switch self {
        case .stock: return "staroflife.circle.fill"
        case .crypto: return "tornado.circle.fill"
        }
    }
    
    var image: Image {
        return .init(systemName: self.systemImageName)
    }
}
