//
//  EditTickerView.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct EditTickerView: View {
    private let store: StoreOf<EditTickerStore>
    
    public init(store: StoreOf<EditTickerStore>) {
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
