//
//  TickerType+Image.swift
//  ToolinderFeatureTradeDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ToolinderDomain

public extension TickerType {
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
