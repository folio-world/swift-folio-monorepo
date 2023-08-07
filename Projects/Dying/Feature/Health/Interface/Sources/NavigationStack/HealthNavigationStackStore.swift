//
//  HomeNavigationStackStore.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import ComposableArchitecture

public struct HealthNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: HealthMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case main(HealthMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Codable, Equatable, Hashable {
            case main(HealthMainStore.State = .init())
        }
        
        public enum Action: Equatable {
            case main(HealthMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.main, action: /Action.main) {
                HealthMainStore()
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
            HealthMainStore()._printChanges()
        }
    }
}
