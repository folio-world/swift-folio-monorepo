//
//  GoalMainStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

public struct GoalMainStore: Reducer {
    public init() {}
    
    public struct State: Codable, Equatable, Hashable {
        var cnt: Int
        
        public init() {
            self.cnt = 0
        }
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.cnt = 5200
                return .none
                
            default:
                return .none
            }
        }
    }
}