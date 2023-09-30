//
//  TradeSide.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public enum TradeSide: String, Codable, CaseIterable {
    case buy = "Buy"
    case sell = "Sell"
}
