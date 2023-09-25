//
//  TickerDetailView.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct TickerDetailView: View {
    private let store: StoreOf<TickerDetailStore>
    
    public init(store: StoreOf<TickerDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        TradeDateChartView(tradeDateChartDataEntity: viewStore.state.tradeDateChartDataEntity)
                            .padding()
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
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
            .navigationTitle(viewStore.state.ticker.name ?? "")
        }
    }
    
    private func titleView() -> some View {
        VStack {
            
        }
    }
}
