//
//  CalendarTrade.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

import ToolinderShared

public struct CalendarEntity: Equatable {
    let date: Date
    let trades: [Trade]
    
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
