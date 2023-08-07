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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                self.store.scope(state: \.path, action: GoalNavigationStackStore.Action.path)
            ) {
                GoalMainView(store: self.store.scope(state: \.main, action: GoalNavigationStackStore.Action.main))
            } destination: {
                switch $0 {
                case .main:
                    CaseLet(
                        /GoalNavigationStackStore.Path.State.main,
                         action: GoalNavigationStackStore.Path.Action.main,
                         then: GoalMainView.init(store:)
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
