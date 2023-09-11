//
//  Fixme.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation
import SwiftData

import ToolinderDomain
import ToolinderShared


//FIXME: Xcode 버전 문제로 예상. 하위 모듈의 SwiftData를 상위에서 읽어올때 오류가 발생하는 문제가 있음.
@Model
public class Ticker {
    public var type: TickerType? = TickerType.stock
    public var currency: Currency? = Currency.dollar
    public var name: String? = ""
    
    @Relationship(inverse: \Trade.ticker) public var trades: [Trade]? = []

    public init(
        type: TickerType,
        currency: Currency,
        name: String
    ) {
        self.type = type
        self.currency = currency
        self.name = name
    }
}


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
