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
}

public typealias TradeDateChartDataEntity = [TradeDateChartData]

public extension [Trade] {
    func toTradeDateChartDataEntity(from fromDate: Date, to toDate: Date) -> TradeDateChartDataEntity {
        let trades = self.sorted(by: { $0.date < $1.date })
        let dates = Date.dates(from: fromDate, to: toDate)
        
        return dates.map { date in
            let trades = trades.filter { $0.date.isEqual(date: date) }
            
            return .init(
                date: date,
                buyCount: trades.filter { $0.side == .buy }.count,
                sellCount: trades.filter { $0.side == .sell }.count
            )
        }
    }
}
