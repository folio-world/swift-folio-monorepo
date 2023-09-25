//
//  TradeDateChartDataEntity.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

public struct TradeDateChartData: Equatable, Hashable {
    public let date: Date
    public let buyCount: Int
    public let sellCount: Int
    public let trades: [Trade]
}

public typealias TradeDateChartDataEntity = [TradeDateChartData]
