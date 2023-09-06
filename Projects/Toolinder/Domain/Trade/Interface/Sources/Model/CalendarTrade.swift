//
//  CalendarTrade.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

import ToolinderShared

public struct CalendarEntity: Equatable, Identifiable {
    public let id: UUID
    public let date: Date
    public let trades: [Trade]
    
    public init(
        id: UUID = .init(),
        date: Date,
        trades: [Trade]
    ) {
        self.id = id
        self.date = date
        self.trades = trades
    }
    
    public static func toDomain(date: Date, trades: [Trade]) -> [CalendarEntity] {
        var calendars: [CalendarEntity] = []
        
        for date in date.allDatesInMonth() {
            let calendar = CalendarEntity(
                date: date,
                trades: trades.filter({ date.isEqual(date: $0.date) })
            )
            calendars.append(calendar)
        }
        return calendars
    }
}
