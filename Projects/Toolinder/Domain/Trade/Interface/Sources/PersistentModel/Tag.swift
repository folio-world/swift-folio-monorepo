//
//  HashTag.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/30.
//

import Foundation
import SwiftData
import SwiftUI

@Model
public class Tag {
    public var color: Color = Color.blue
    public var name: String = ""
    
    @Relationship public var tickers: [Ticker] = []
    
    public init(
        color: Color,
        name: String,
        tickers: [Ticker]
    ) {
        self.tickers = tickers
    }
}
