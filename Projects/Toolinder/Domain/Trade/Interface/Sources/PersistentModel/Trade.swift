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
    public let id: UUID = UUID()
    public var side: TradeSide = TradeSide.buy
    public var price: Double = 0
    public var quantity: Double = 0
    public var fee: Double = 0
    public var images: [Data] = []
    public var note: String = ""
    public var date: Date = Date.now
    
    @Relationship public var ticker: Ticker?
    
    public init(
        id: UUID = .init(),
        side: TradeSide,
        price: Double,
        quantity: Double,
        fee: Double,
        images: [Data],
        note: String,
        date: Date,
        ticker: Ticker?
    ) {
        self.id = id
        self.side = side
        self.images = images
        self.price = price
        self.quantity = quantity
        self.fee = fee
        self.note = note
        self.date = date
        self.ticker = ticker
    }
}
