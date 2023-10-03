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
            HStack(spacing: 10) {
                symbolView(viewStore: viewStore)
                
                nameView(viewStore: viewStore)
                
                if viewStore.mode == .item {
                    Spacer()
                    
                    tradeSummaryView(viewStore: viewStore)
                }
            }
            .onTapGesture {
                viewStore.send(.tapped)
            }
            .frame(height: 35)
            .padding(10)
            .background(viewStore.state.isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
        }
    }
    
    private func symbolView(viewStore: ViewStoreOf<TickerItemCellStore>) -> some View {
        VStack {
            viewStore.state.ticker.type.image
                .font(.title3)
            
            if viewStore.mode == .item {
                Text("\(viewStore.state.ticker.type.rawValue)")
                    .font(.caption2)
                    .frame(width: 40)
            }
        }
    }
    
    private func nameView(viewStore: ViewStoreOf<TickerItemCellStore>) -> some View {
        HStack {
            Text("\(viewStore.state.ticker.name) \(viewStore.state.ticker.trades?.count ?? 0)" )
                .font(.body)
                .fontWeight(.semibold)
            
            HStack(spacing: 1) {
                ForEach(viewStore.state.ticker.tags ?? [], id: \.self) { tag in
                    Circle()
                        .fill(Color(hex: tag.hex))
                        .frame(width: 5, height: 5)
                }
            }
        }
    }
    
    private func tradeSummaryView(viewStore: ViewStoreOf<TickerItemCellStore>) -> some View {
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
