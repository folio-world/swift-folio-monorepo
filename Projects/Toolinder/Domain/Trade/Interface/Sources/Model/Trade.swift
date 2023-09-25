//
//  TradeEntity.swift
//  ToolinderDomainTrade
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation
import SwiftData

@Model
public class Trade {
    public var side: TradeSide?
    public var price: Double?
    public var volume: Double?
    public var images: [Data] = []
    public var note: String?
    public var date: Date = Date()
    
    @Relationship public var ticker: Ticker?
    
    public init(
        side: TradeSide? = nil,
        price: Double? = 0.0,
        volume: Double? = 0.0,
        images: [Data] = [],
        note: String? = "",
        date: Date = Date(),
        ticker: Ticker? = nil
    ) {
        self.side = side
        self.images = images
        self.price = price
        self.volume = volume
        self.note = note
        self.date = date
        self.ticker = ticker
    }
}

public extension [Trade] {
    func toDomain() -> TickerTypeChartDataEntity {
        return TickerType.allCases.map { type in
            let trades = self.filter({ $0.ticker?.type == type })
            let hold = trades.map { trade in
                let sum: Double = (trade.price ?? 0.0) * (trade.volume ?? 0.0)
                let sign: Double = trade.side == .buy ? 1.0 : -1.0
                
                return sum * sign
            }.reduce(0.0, +)
            
            return .init(
                tickerType: type,
                hold: hold,
                trades: trades
            )
        }
    }
    
    func toDomain(from fromDate: Date, to toDate: Date) -> TradeDateChartDataEntity {
        let trades = self.sorted(by: { $0.date < $1.date })
        let dates = Date.dates(from: fromDate, to: toDate)
        
        return dates.map { date in
            let trades = trades.filter { $0.date.isEqual(date: date) }
            
            return .init(
                date: date,
                buyCount: trades.filter { $0.side == .buy }.count,
                sellCount: trades.filter { $0.side == .sell }.count,
                trades: trades
            )
        }
    }
    
    func scale(startDate: Date, endDate: Date) -> [Trade] {
        return []
    }
}
