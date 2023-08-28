//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

public struct CalendarNavigationStackView: View {
    let store: StoreOf<CalendarNavigationStackStore>
    
    public init(store: StoreOf<CalendarNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
                state: \.path,
                action: CalendarNavigationStackStore.Action.path)) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                GoalMainView(
                    store: self.store.scope(
                        state: \.main,
                        action: CalendarNavigationStackStore.Action.main))
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /CalendarNavigationStackStore.Path.State.detail,
                     action: CalendarNavigationStackStore.Path.Action.detail,
                     then: GoalDetailView.init(store:))
            }
        }
    }
}
