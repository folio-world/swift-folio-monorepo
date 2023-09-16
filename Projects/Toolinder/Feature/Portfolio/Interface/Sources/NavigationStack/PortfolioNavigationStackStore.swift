//
//  MyPageNavigationStackStore.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/08/28.
//

import ComposableArchitecture

public struct PortfolioNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: PortfolioMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(PortfolioMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case detail(GoalDetailStore.State)
        }
        
        public enum Action: Equatable {
            case detail(GoalDetailStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                GoalDetailStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            PortfolioMainStore()._printChanges()
        }
        
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
