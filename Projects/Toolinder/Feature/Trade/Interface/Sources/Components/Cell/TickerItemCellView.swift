//
//  TickerItemCellView.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct TickerItemCellView: View {
    private let store: StoreOf<TickerItemCellStore>
    
    public init(store: StoreOf<TickerItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                tradeView(viewStore: viewStore)
            }
        }
    }
    
    private func tradeView(viewStore: ViewStoreOf<TickerItemCellStore>) -> some View {
        HStack(spacing: 10) {
            VStack {
                viewStore.state.ticker.type.image
                    .font(.title3)
                
                if viewStore.mode == .item {
                    Text("\(viewStore.state.ticker.type.rawValue)")
                        .font(.caption2)
                }
            }
            
            Text("\(viewStore.state.ticker.name) \(viewStore.state.ticker.trades.count)" )
                .font(.body)
                .fontWeight(.semibold)
            
            if viewStore.mode == .item {
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Text("\(Int(viewStore.tickerSummaryDataEntity.profit)) \(viewStore.state.ticker.currency.rawValue) (\(Int(viewStore.tickerSummaryDataEntity.yield))%)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(Int(viewStore.tickerSummaryDataEntity.yield) > 0 ? .pink : .mint)
                    }
                    
                    HStack(spacing: .zero) {
                        Spacer()
                        
                        Text("\(Int(viewStore.tickerSummaryDataEntity.avgPrice)) \(viewStore.state.ticker.currency.rawValue)")
                            .font(.caption2)
                    }
                    
                    HStack(spacing: .zero) {
                        Spacer()

                        Text("\(Int(viewStore.tickerSummaryDataEntity.currentVolume)) vol")
                            .font(.caption2)
                    }
                }
            }
        }
        .frame(height: 35)
        .padding(10)
        .background(viewStore.state.isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
        .onTapGesture {
            viewStore.send(.tapped)
        }
    }
}
