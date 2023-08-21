//
//  HomeNavigationStackView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct HealthNavigationStackView: View {
    let store: StoreOf<HealthNavigationStackStore>
    
    public init(store: StoreOf<HealthNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: HealthNavigationStackStore.Action.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                HealthMainView(store: self.store.scope(state: \.main, action: HealthNavigationStackStore.Action.main))
                    .onAppear {
                        viewStore.send(.onAppear)
                    }
            }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /HealthNavigationStackStore.Path.State.detail,
                     action: HealthNavigationStackStore.Path.Action.detail,
                     then: HealthDetailView.init(store:))
            }
        }
    }
}
