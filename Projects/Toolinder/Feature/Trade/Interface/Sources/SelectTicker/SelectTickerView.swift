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
                VStack {
                    EditHeaderView(
                        mode: .select,
                        title: "Ticker",
                        isShowNewButton: true
                    ) { _ in }
                        .padding()
                    
                    if viewStore.tickerItem.isEmpty {
                        tickerItemListEmptyView(viewStore: viewStore)
                            .padding()
                    } else {
                        tickerItemListView()
                            .padding()
                    }
                }
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
    
    private func tickerItemListEmptyView(viewStore: ViewStoreOf<SelectTickerStore>) -> some View {
        HStack {
            Button(action: {
                viewStore.send(.addButtonTapped)
            }, label: {
                Image(systemName: "cloud.rain.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.foreground)
            })
        }
    }
}
