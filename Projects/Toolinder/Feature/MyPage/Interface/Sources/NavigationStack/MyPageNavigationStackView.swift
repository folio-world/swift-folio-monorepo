//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageNavigationStackView: View {
    let store: StoreOf<MyPageNavigationStackStore>
    
    public init(store: StoreOf<MyPageNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
                state: \.path,
                action: MyPageNavigationStackStore.Action.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GoalMainView(
                    store: self.store.scope(
                        state: \.main,
                        action: MyPageNavigationStackStore.Action.main))
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /MyPageNavigationStackStore.Path.State.detail,
                     action: MyPageNavigationStackStore.Path.Action.detail,
                     then: GoalDetailView.init(store:))
            }
        }
    }
}
