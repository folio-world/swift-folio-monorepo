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
            case detail(HealthDetailStore.State)
        }
        
        public enum Action: Equatable {
            case detail(HealthDetailStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                HealthDetailStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .main(action):
                switch action {
                case let .goToDetail(healthDetailState):
                    state.path = .init()
                    state.path.append(.detail(healthDetailState))
                default: return .none
                }
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            HealthMainStore()._printChanges()
        }
        
        .forEach(\.path, action: /Action.path) {
          Path()
        }
    }
}
