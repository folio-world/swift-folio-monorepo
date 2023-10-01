//
//  TickerDTO.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/26.
//

import Foundation
import SwiftData

public class TickerDTO {
    public let id: UUID
    public var type: TickerType
    public var currency: Currency
    public var name: String
    public var tag: Tag
    
    public init(
        id: UUID = .init(),
        type: TickerType,
        currency: Currency,
        name: String
    ) {
        self.id = id
        self.type = type
        self.currency = currency
        self.name = name
    }
    
    func toDomain() -> Ticker {
        return Ticker(
            id: id,
            type: type,
            currency: currency,
            name: name,
            tags:
        )
    }
}
