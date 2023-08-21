//
//  HomeNavigationStackStore.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import ComposableArchitecture

public struct LifespanNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: LifespanMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case main(LifespanMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Codable, Equatable, Hashable {
            case main(LifespanMainStore.State = .init())
        }
        
        public enum Action: Equatable {
            case main(LifespanMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.main, action: /Action.main) {
                LifespanMainStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            LifespanMainStore()._printChanges()
        }
    }
}
