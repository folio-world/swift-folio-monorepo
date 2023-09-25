//
//  TradeDateChartDataEntity.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

public struct TradeDateChartData: Equatable {
    public let date: Date
    public let count: Int
    public let trades: [Trade]
}

public typealias TradeDateChartDataEntity = [TradeDateChartData]
