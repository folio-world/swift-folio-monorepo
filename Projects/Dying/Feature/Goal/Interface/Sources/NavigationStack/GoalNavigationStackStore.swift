//
//  RootGoalStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

public struct GoalNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: GoalMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case main(GoalMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Codable, Equatable, Hashable {
            case main(GoalMainStore.State = .init())
        }
        
        public enum Action: Equatable {
            case main(GoalMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.main, action: /Action.main) {
                GoalMainStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            GoalMainStore()
        }
    }
}
