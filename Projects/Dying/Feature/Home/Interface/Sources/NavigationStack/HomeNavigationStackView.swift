//
//  HomeNavigationStackView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct HomeNavigationStackView: View {
    let store: StoreOf<HomeNavigationStackStore>
    
    public init(store: StoreOf<HomeNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                self.store.scope(state: \.path, action: HomeNavigationStackStore.Action.path)
            ) {
                HomeMainView(store: self.store.scope(state: \.main, action: HomeNavigationStackStore.Action.main))
            } destination: {
                switch $0 {
                case .main:
                    CaseLet(
                        /HomeNavigationStackStore.Path.State.main,
                         action: HomeNavigationStackStore.Path.Action.main,
                         then: HomeMainView.init(store:)
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
