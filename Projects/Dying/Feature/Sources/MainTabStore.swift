//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import DyingFeatureHomeInterface
import DyingFeatureHome
import DyingFeatureLifespanInterface
import DyingFeatureLifespan
import DyingFeatureGoalInterface
import DyingFeatureGoal
import DyingFeatureHealthInterface
import DyingFeatureHealth
import DyingFeatureMyPageInterface
import DyingFeatureMyPage

public struct MainTabStore: Reducer {
    public init() {}
    
    public enum Tab: String {
        case home = "Home"
        case lifespan = "Lifespan"
        case health = "Health"
        case goal = "Goal"
        case myPage = "My"
    }
    
    public struct State: Equatable {
        var home: HomeNavigationStackStore.State = .init()
        var lifespan: LifespanNavigationStackStore.State = .init()
        var health: HealthNavigationStackStore.State = .init()
        var goal: GoalNavigationStackStore.State = .init()
        var myPage: MyPageNavigationStackStore.State = .init()
        
        var currentTab: Tab = .health
        
        public init() {
            home = HomeNavigationStackStore.State()
            lifespan = LifespanNavigationStackStore.State()
            health = HealthNavigationStackStore.State()
            goal = GoalNavigationStackStore.State()
            myPage = MyPageNavigationStackStore.State()
            
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case selectTab(Tab)
        
        case home(HomeNavigationStackStore.Action)
        case lifespan(LifespanNavigationStackStore.Action)
        case health(HealthNavigationStackStore.Action)
        case goal(GoalNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                state = .init()
                return .none
                
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.home, action: /Action.home) {
            HomeNavigationStackStore()._printChanges()
        }
        Scope(state: \.lifespan, action: /Action.lifespan) {
            LifespanNavigationStackStore()._printChanges()
        }
        Scope(state: \.health, action: /Action.health) {
            HealthNavigationStackStore()._printChanges()
        }
        Scope(state: \.goal, action: /Action.goal) {
            GoalNavigationStackStore()._printChanges()
        }
        Scope(state: \.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()._printChanges()
        }
    }
}
