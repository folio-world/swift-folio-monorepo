//
//  MyPageNavigationStackStore.swift
//  DyingFeatureMyPageInterface
//
//  Created by 송영모 on 2023/08/07.
//

import ComposableArchitecture

public struct MyPageNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: MyPageMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case main(MyPageMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Codable, Equatable, Hashable {
            case main(MyPageMainStore.State = .init())
        }
        
        public enum Action: Equatable {
            case main(MyPageMainStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.main, action: /Action.main) {
                MyPageMainStore()
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
            MyPageMainStore()._printChanges()
        }
    }
}
