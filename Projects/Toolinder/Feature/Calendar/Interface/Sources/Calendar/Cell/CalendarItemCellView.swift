//
//  CalendarItemCellView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct CalendarItemCellView: View {
    private let store: StoreOf<CalendarItemCellStore>
    
    public init(store: StoreOf<CalendarItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 2) {
                HStack {
                    Spacer()
                    
                    Text("\(viewStore.state.date.day)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(viewStore.state.isSelected ? .white : .black)
                    
                    Spacer()
                }
                .padding(.top, 2)
                
                ForEachStore(self.store.scope(state: \.tradePreviewItem, action: CalendarItemCellStore.Action.tradePreviewItem(id:action:))) {
                    TradePreviewItemCellView(store: $0)
                }
                
                Spacer()
            }
            .background(viewStore.state.isSelected ? .black : .white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
        }
    }
}

