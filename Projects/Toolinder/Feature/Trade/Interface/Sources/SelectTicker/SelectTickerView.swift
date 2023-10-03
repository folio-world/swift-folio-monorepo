//
//  SelectTicker.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import SwiftUI

import ComposableArchitecture

import ToolinderShared

public struct SelectTickerView: View {
    public let store: StoreOf<SelectTickerStore>
    
    public init(store: StoreOf<SelectTickerStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                headerView(viewStore: viewStore)
                    .padding()
                
                tickerItemListView()
                    .padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$editTicker,
                    action: { .editTicker($0) }
                )
            ) {
                EditTickerView(store: $0)
                    .presentationDetents([.medium])
            }
        }
    }
    
    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<SelectTickerStore>) -> some View {
        EditHeaderView(
            mode: .select,
            title: "Ticker",
            isShowNewButton: true
        ) { mode in
            switch mode {
            case .new:
                viewStore.send(.addButtonTapped)
            default: break
            }
        }
    }
    
    private func tickerItemListView() -> some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 10, maximum: 500)), count: 3), alignment: .leading, spacing: 10) {
            ForEachStore(self.store.scope(state: \.tickerItem, action: SelectTickerStore.Action.tickerItem(id:action:))) {
                TickerItemCellView(store: $0)
            }
        }
        .padding(.horizontal)
    }
}
