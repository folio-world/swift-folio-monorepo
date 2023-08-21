//
//  GoalDetailView.swift
//  DyingFeatureGoalDemo
//
//  Created by 송영모 on 2023/08/08.
//

import SwiftUI

import ComposableArchitecture

public struct GoalDetailView: View {
    let store: StoreOf<GoalDetailStore>
    
    public init(store: StoreOf<GoalDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                Text("detail view")
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
        }
    }
}
