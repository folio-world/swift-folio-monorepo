//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

public struct GoalNavigationStackView: View {
    let store: StoreOf<GoalNavigationStackStore>
    
    public init(store: StoreOf<GoalNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
                state: \.path,
                action: GoalNavigationStackStore.Action.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GoalMainView(
                    store: self.store.scope(
                        state: \.main,
                        action: GoalNavigationStackStore.Action.main))
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /GoalNavigationStackStore.Path.State.detail,
                     action: GoalNavigationStackStore.Path.Action.detail,
                     then: GoalDetailView.init(store:))
            }
        }
    }
}
