//
//  TagItemCellView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct TagItemCellView: View {
    private let store: StoreOf<TagItemCellStore>
    
    public init(store: StoreOf<TagItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 2) {
                Circle()
                    .fill(Color(hex: viewStore.state.tag.hex))
                
//                RoundedRectangle(cornerRadius: 3)
//                    .fill(viewStore.state.trade.side == .buy ? .pink : .mint)
//                    .frame(width: 2.5, height: 11)
                
//                Text(viewStore.state.trade.ticker?.name ?? "")
//                    .font(.caption2)
//                    .fontWeight(.light)
//                    .foregroundStyle(Color.blackOrWhite(!viewStore.state.isSelected))
                
                Spacer()
            }
            .padding(10)
            .background(Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
        }
    }
}
