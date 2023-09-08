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
    public var type: TickerType?
    public var currency: Currency?
    public var name: String?
    
    @Relationship(inverse: \Trade.ticker) public var trades: [Trade]?

    public init(
        type: TickerType,
        currency: Currency,
        name: String
    ) {
        self.type = type
        self.currency = currency
        self.name = name
    }
}
