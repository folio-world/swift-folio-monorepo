//
//  TickerType+Image.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/10.
//

import SwiftUI

import ToolinderDomain

extension TickerType {
    var systemImageName: String {
        switch self {
        case .stock: return "staroflife.circle.fill"
        case .crypto: return "tornado.circle.fill"
        }
    }
}
