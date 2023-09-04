//
//  TradeCopy.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation
import SwiftData

import ToolinderDomain

//FIXME: xcode beta 버전에서 하위 모듈의 class를 찾지 못하는 현상
@Model
public class Trade {
    public var name: String
    public var type: TradeType
    public var currency: Tradecurrency
    public var side: TradeSide
    public var images: [Data]
    public var price: Double
    public var volume: Double
    public var note: String
    public var date: Date

    public init(
        name: String = "",
        type: TradeType = .stock,
        currency: Tradecurrency = .krw,
        side: TradeSide = .buy,
        images: [Data] = [],
        price: Double = 0.0,
        volume: Double = 0.0,
        note: String = "",
        date: Date = Date()
    ) {
        self.name = name
        self.type = type
        self.currency = currency
        self.side = side
        self.images = images
        self.price = price
        self.volume = volume
        self.note = note
        self.date = date
    }
}

