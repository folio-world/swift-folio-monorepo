//
//  TradeDTO.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/16.
//

import Foundation
import SwiftData

public struct TradeDTO {
    public var side: TradeSide
    public var price: Double
    public var volume: Double
    public var fee: Double
    public var images: [Data]
    public var note: String
    public var date: Date
    
    public var ticker: Ticker?
    
    public init(
        side: TradeSide = .buy,
        price: Double = 0,
        volume: Double = 0,
        fee: Double = 0,
        images: [Data] = [],
        note: String = "",
        date: Date = .now,
        ticker: Ticker
    ) {
        self.side = side
        self.images = images
        self.price = price
        self.volume = volume
        self.fee = fee
        self.note = note
        self.date = date
        self.ticker = ticker
    }
    
    func toDomain() -> Trade {
        return Trade(
            side: side,
            price: price,
            volume: volume,
            fee: fee,
            images: images,
            note: note,
            date: date,
            ticker: ticker
        )
    }
}

