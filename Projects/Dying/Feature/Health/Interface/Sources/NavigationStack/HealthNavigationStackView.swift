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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                self.store.scope(state: \.path, action: HealthNavigationStackStore.Action.path)
            ) {
                HealthMainView(store: self.store.scope(state: \.main, action: HealthNavigationStackStore.Action.main))
            } destination: {
                switch $0 {
                case .main:
                    CaseLet(
                        /HealthNavigationStackStore.Path.State.main,
                         action: HealthNavigationStackStore.Path.Action.main,
                         then: HealthMainView.init(store:)
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
