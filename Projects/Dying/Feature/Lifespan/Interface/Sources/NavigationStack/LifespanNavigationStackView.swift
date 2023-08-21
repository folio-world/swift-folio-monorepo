//
//  HomeNavigationStackView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct LifespanNavigationStackView: View {
    let store: StoreOf<LifespanNavigationStackStore>
    
    public init(store: StoreOf<LifespanNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                self.store.scope(state: \.path, action: LifespanNavigationStackStore.Action.path)
            ) {
                LifespanMainView(store: self.store.scope(state: \.main, action: LifespanNavigationStackStore.Action.main))
            } destination: {
                switch $0 {
                case .main:
                    CaseLet(
                        /LifespanNavigationStackStore.Path.State.main,
                         action: LifespanNavigationStackStore.Path.Action.main,
                         then: LifespanMainView.init(store:)
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
