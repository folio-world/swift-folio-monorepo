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
            case whatIsNew(WhatIsNewStore.State)
        }
        
        public enum Action: Equatable {
            case whatIsNew(WhatIsNewStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.whatIsNew, action: /Action.whatIsNew) {
                WhatIsNewStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .main(.delegate(action)):
                switch action {
                case .navigateToWhatIsNew:
                    state.path.append(.whatIsNew(.init()))
                    return .none
                }
                
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
