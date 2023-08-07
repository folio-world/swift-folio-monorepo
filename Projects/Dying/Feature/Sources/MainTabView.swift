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
import DyingFeatureHealthInterface
import DyingFeatureHealth
import DyingFeatureMyPageInterface
import DyingFeatureMyPage

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
                        Label("Home", systemImage: "house")
                    }
                
                HealthNavigationStackView(store: self.store.scope(state: \.health, action: MainTabStore.Action.health))
                    .tabItem {
                        Label("Health", systemImage: "heart")
                    }
                
                GoalNavigationStackView(store: self.store.scope(state: \.goal, action: MainTabStore.Action.goal))
                    .tabItem {
                        Label("Goal", systemImage: "burst")
                    }
                
                MyPageNavigationStackView(store: self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage))
                    .tabItem {
                        Label("My", systemImage: "person.crop.circle")
                    }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
