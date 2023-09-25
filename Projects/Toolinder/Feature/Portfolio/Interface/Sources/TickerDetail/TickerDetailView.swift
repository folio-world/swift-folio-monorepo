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
            ScrollView {
                VStack {
                    
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
