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
}

public typealias TickerTypeChartDataEntity = [TickerTypeChartData]

public extension [Trade] {
    func toTickerTypeChartDataEntity() -> TickerTypeChartDataEntity {
        return TickerType.allCases.map { type in
            let trades = self.filter({ $0.ticker?.type == type })
            let hold = trades.map { trade in
                let sum: Double = (trade.price ?? 0.0) * (trade.volume ?? 0.0)
                let sign: Double = trade.side == .buy ? 1.0 : -1.0
                
                return sum * sign
            }.reduce(0.0, +)
            
            return .init(
                tickerType: type,
                hold: hold
            )
        }
    }
}
