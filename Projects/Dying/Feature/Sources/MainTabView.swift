//
//  MainTabView.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import SwiftUI

import ComposableArchitecture

import DyingFeatureHomeInterface
import DyingFeatureHome
import DyingFeatureGoalInterface
import DyingFeatureGoal

public struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    
    public init(store: StoreOf<MainTabStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                HomeNavigationStackView(store: self.store.scope(state: \.home, action: MainTabStore.Action.home))
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                GoalNavigationStackView(store: self.store.scope(state: \.goal, action: MainTabStore.Action.goal))
                    .tabItem {
                        Image(systemName: "burst")
                    }
            }
        }
    }
}
