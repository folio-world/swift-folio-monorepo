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
import DyingFeatureLifespanInterface
import DyingFeatureLifespan
import DyingFeatureHealthInterface
import DyingFeatureHealth
import DyingFeatureGoalInterface
import DyingFeatureGoal
import DyingFeatureMyPageInterface
import DyingFeatureMyPage

public struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    
    public init(store: StoreOf<MainTabStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.currentTab, send: MainTabStore.Action.selectTab)) {
                HomeNavigationStackView(store: self.store.scope(state: \.home, action: MainTabStore.Action.home))
                    .tabItem {
                        Label(MainTabStore.Tab.home.rawValue, systemImage: "chart.bar.xaxis")
                    }
                    .tag(MainTabStore.Tab.home)
                
                LifespanNavigationStackView(store: self.store.scope(state: \.lifespan, action: MainTabStore.Action.lifespan))
                    .tabItem {
                        Label(MainTabStore.Tab.lifespan.rawValue, systemImage: "sparkles")
                    }
                    .tag(MainTabStore.Tab.lifespan)
                
                HealthNavigationStackView(store: self.store.scope(state: \.health, action: MainTabStore.Action.health))
                    .tabItem {
                        Label(MainTabStore.Tab.health.rawValue, systemImage: "heart")
                    }
                    .tag(MainTabStore.Tab.health)
                
                GoalNavigationStackView(store: self.store.scope(state: \.goal, action: MainTabStore.Action.goal))
                    .tabItem {
                        Label(MainTabStore.Tab.goal.rawValue, systemImage: "burst")
                    }
                    .tag(MainTabStore.Tab.goal)
                
                MyPageNavigationStackView(store: self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage))
                    .tabItem {
                        Label(MainTabStore.Tab.myPage.rawValue, systemImage: "person.crop.circle")
                    }
                    .tag(MainTabStore.Tab.myPage)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
