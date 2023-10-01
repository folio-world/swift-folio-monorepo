//
//  TradeDTO.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/16.
//

import Foundation
import SwiftData

public struct TradeDTO {
    public let id: UUID
    public var side: TradeSide
    public var price: Double
    public var quantity: Double
    public var fee: Double
    public var images: [Data]
    public var note: String
    public var date: Date
    
    public var ticker: Ticker?
    
    public init(
        id: UUID = .init(),
        side: TradeSide = .buy,
        price: Double = 0,
        quantity: Double = 0,
        fee: Double = 0,
        images: [Data] = [],
        note: String = "",
        date: Date = .now,
        ticker: Ticker
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
    
    func toDomain() -> Trade {
        return Trade(
            id: id,
            side: side,
            price: price,
            quantity: quantity,
            fee: fee,
            images: images,
            note: note,
            date: date,
            ticker: ticker
        )
    }
}

