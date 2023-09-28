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
    public var side: TradeSide = TradeSide.buy
    public var price: Double = 0
    public var volume: Double = 0
    public var fee: Double = 0
    public var images: [Data] = []
    public var note: String = ""
    public var date: Date = Date.now
    
    @Relationship public var ticker: Ticker?
    
    public init(
        side: TradeSide,
        price: Double,
        volume: Double,
        images: [Data],
        note: String,
        date: Date,
        ticker: Ticker?
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
