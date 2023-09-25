//
//  TickerTypeChartDataEntity.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

public struct TickerTypeChartData: Equatable, Hashable {
    public let tickerType: TickerType
    public let hold: Double
    public let trades: [Trade]
}

public typealias TickerTypeChartDataEntity = [TickerTypeChartData]
