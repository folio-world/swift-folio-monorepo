//
//  MyPageNavigationStackView.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/08/28.
//

import SwiftUI

import ComposableArchitecture

public struct PortfolioNavigationStackView: View {
    let store: StoreOf<PortfolioNavigationStackStore>
    
    public init(store: StoreOf<PortfolioNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
                state: \.path,
                action: PortfolioNavigationStackStore.Action.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                PortfolioMainView(
                    store: self.store.scope(
                        state: \.main,
                        action: PortfolioNavigationStackStore.Action.main
                    )
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: {
            switch $0 {
            case .tickerDetail:
                CaseLet(
                    /PortfolioNavigationStackStore.Path.State.tickerDetail,
                     action: PortfolioNavigationStackStore.Path.Action.tickerDetail,
                     then: TickerDetailView.init(store:))
            }
        }
    }
}
