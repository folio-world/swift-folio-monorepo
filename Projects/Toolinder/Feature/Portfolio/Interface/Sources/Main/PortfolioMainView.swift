//
//  PortfolioMainView.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI

import ComposableArchitecture

public struct PortfolioMainView: View {
    let store: StoreOf<PortfolioMainStore>
    
    public init(store: StoreOf<PortfolioMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack {
                    headerView(viewStore: viewStore)
                }
            }
            .navigationTitle("Portfolio")
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<PortfolioMainStore>) -> some View {
        HStack {
            Spacer()
            
            Picker("", selection: viewStore.binding(get: \.selectedPeriod, send: PortfolioMainStore.Action.selectPeriod)) {
                ForEach(PortfolioMainStore.Period.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
        }
    }
}
