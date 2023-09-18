//
//  TradePreviewItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ToolinderDomain
import ToolinderShared

public struct TradePreviewItem: View {
    private let trade: Trade
    
    public init(trade: Trade) {
        self.trade = trade
    }
    
    public var body: some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 3)
                .fill(trade.side == .buy ? .pink : .mint)
                .frame(width: 2.5, height: 11)
            
            Text(trade.ticker?.name ?? "")
                .font(.caption2)
                .fontWeight(.light)
        }
    }
}
