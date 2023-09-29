//
//  TradePreviewItemCellView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct TradePreviewItemCellView: View {
    private let store: StoreOf<TradePreviewItemCellStore>
    
    public init(store: StoreOf<TradePreviewItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 2) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(viewStore.state.trade.side == .buy ? .pink : .mint)
                    .frame(width: 2.5, height: 11)
                
                Text(viewStore.state.trade.ticker?.name ?? "")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(Color.blackOrWhite(!viewStore.state.isSelected))
                
                Spacer()
            }
        }
    }
}
