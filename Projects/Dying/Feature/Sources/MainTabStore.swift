//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import DyingFeatureHomeInterface
import DyingFeatureHome
import DyingFeatureGoalInterface
import DyingFeatureGoal


public struct MainTabStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var home: HomeNavigationStackStore.State = .init()
        var goal: GoalNavigationStackStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case home(HomeNavigationStackStore.Action)
        case goal(GoalNavigationStackStore.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        Scope(state: \.home, action: /Action.home) {
            HomeNavigationStackStore()._printChanges()
        }
        Scope(state: \.goal, action: /Action.goal) {
            GoalNavigationStackStore()._printChanges()
        }
    }
}
