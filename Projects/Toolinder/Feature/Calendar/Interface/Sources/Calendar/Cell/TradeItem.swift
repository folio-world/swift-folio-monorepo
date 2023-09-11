//
//  TradeItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ToolinderShared
import ToolinderDomain

public struct TradeItem: View {
    private let trade: Trade
    
    public var action: () -> Void
    public var trailingAction: () -> Void
    
    public init(
        trade: Trade,
        action: @escaping () -> Void = {},
        trailingAction: @escaping () -> Void = {}
    ) {
        self.trade = trade
        self.action = action
        self.trailingAction = trailingAction
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            Text(trade.date.localizedString(dateStyle: .none, timeStyle: .short))
                .font(.headline)
                .fontWeight(.semibold)
            
            trade.ticker?.type?.image
                .font(.title3)
                .foregroundStyle(trade.side == .buy ? .pink : .mint)
            
            Text(trade.ticker?.name ?? "")
                .font(.body)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .frame(height: 35)
        .padding(10)
        .background(Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
        .onTapGesture {
            self.action()
        }
    }
}
