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

    public init(
        type: TickerType? = nil,
        name: String? = nil
    ) {
        self.type = type
        self.name = name
    }
}
