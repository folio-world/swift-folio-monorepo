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
                    state: \.$tickerEdit,
                    action: { .tickerEdit($0) }
                )
            ) {
                TickerEditView(store: $0)
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        viewStore.send(.editButtonTapped)
                    }
                }
            }
            .navigationTitle(viewStore.state.ticker.name ?? "")
        }
    }
    
    private func titleView() -> some View {
        VStack {
            
        }
    }
}
