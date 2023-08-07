//
//  MyPageNavigationStackView.swift
//  DyingFeatureMyPageInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageNavigationStackView: View {
    let store: StoreOf<MyPageNavigationStackStore>
    
    public init(store: StoreOf<MyPageNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStackStore(
                self.store.scope(state: \.path, action: MyPageNavigationStackStore.Action.path)
            ) {
                MyPageMainView(store: self.store.scope(state: \.main, action: MyPageNavigationStackStore.Action.main))
            } destination: {
                switch $0 {
                case .main:
                    CaseLet(
                        /MyPageNavigationStackStore.Path.State.main,
                         action: MyPageNavigationStackStore.Path.Action.main,
                         then: MyPageMainView.init(store:)
                    )
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
