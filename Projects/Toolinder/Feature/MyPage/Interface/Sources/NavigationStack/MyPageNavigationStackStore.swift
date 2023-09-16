//
//  RootGoalStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

public struct MyPageNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: MyPageMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(MyPageMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case existingUserPolicy(ExistingUserPolicyStore.State)
        }
        
        public enum Action: Equatable {
            case existingUserPolicy(ExistingUserPolicyStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.existingUserPolicy, action: /Action.existingUserPolicy) {
                ExistingUserPolicyStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .main(.delegate(.existingUserPolicy)):
                state.path.append(.existingUserPolicy(.init()))
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            MyPageMainStore()._printChanges()
        }
        
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
