//
//  TradeEntity.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation
import SwiftData

@Model
public class Trade {
    public var side: TradeSide?
    public var price: Double?
    public var volume: Double?
    public var images: [Data] = []
    public var note: String?
    public var date: Date = Date()
    
    @Relationship public var ticker: Ticker?
    
    public init(
        side: TradeSide? = nil,
        price: Double? = 0.0,
        volume: Double? = 0.0,
        images: [Data] = [],
        note: String? = "",
        date: Date = Date(),
        ticker: Ticker? = nil
    ) {
        self.side = side
        self.images = images
        self.price = price
        self.volume = volume
        self.note = note
        self.date = date
        self.ticker = ticker
    }
}
