//
//  HomeNavigationStackStore.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import ComposableArchitecture

public struct HomeNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: HomeMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case main(HomeMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Codable, Equatable, Hashable {
            case main(HomeMainStore.State = .init())
        }
        
        public enum Action: Equatable {
            case main(HomeMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.main, action: /Action.main) {
                HomeMainStore()
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
            HomeMainStore()._printChanges()
        }
    }
}
