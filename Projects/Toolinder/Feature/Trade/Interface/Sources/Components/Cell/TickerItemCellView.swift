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
            viewStore.state.ticker.type?.image
                .font(.title3)
            
            Text(viewStore.state.ticker.name ?? "")
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
            viewStore.send(.tapped)
        }
    }
}
