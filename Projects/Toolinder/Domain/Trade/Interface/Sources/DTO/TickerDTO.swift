//
//  TickerDTO.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation
import SwiftData

public class TickerDTO {
    public var type: TickerType?
    public var currency: Currency?
    public var name: String?
    
    public init(
        type: TickerType,
        currency: Currency,
        name: String
    ) {
        self.type = type
        self.currency = currency
        self.name = name
    }
    
    func toDomain() -> Ticker {
        return .init(
            type: type,
            currency: currency,
            name: name
        )
    }
}
