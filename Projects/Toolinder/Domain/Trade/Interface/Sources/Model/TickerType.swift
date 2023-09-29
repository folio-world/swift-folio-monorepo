//
//  TradeType.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public enum TickerType: String, Codable, CaseIterable, Equatable {
    case stock = "Stock"
    case crypto = "Crypto"
    case gold = "Gold"
    case realEstate = "Real Estate"
}
