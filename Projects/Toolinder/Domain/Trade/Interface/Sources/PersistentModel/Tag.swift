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
    public let id: UUID = UUID()
    public var hex: String = ""
    public var name: String = ""
    
    @Relationship public var tickers: [Ticker]? = []
    
    public init(
        id: UUID = .init(),
        hex: String,
        name: String
    ) {
        self.id = id
        self.hex = hex
        self.name = name
    }
}
