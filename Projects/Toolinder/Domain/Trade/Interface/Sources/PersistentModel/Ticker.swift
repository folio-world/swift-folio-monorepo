//
//  Ticker.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/08.
//

import Foundation
import SwiftData

@Model
public class Ticker {
    public let id: UUID = UUID()
    public var type: TickerType = TickerType.stock
    public var currency: Currency = Currency.dollar
    public var name: String = ""
    
    @Relationship(deleteRule: .cascade, inverse: \Trade.ticker) public var trades: [Trade]? = []
    @Relationship(inverse: \Tag.tickers) public var tags: [Tag]? = []

    public init(
        id: UUID = .init(),
        type: TickerType,
        currency: Currency,
        name: String,
        tags: [Tag]
    ) {
        self.id = id
        self.type = type
        self.currency = currency
        self.name = name
        self.tags = tags
    }
}
