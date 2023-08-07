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
        var isShow: Bool = false
        
        public init() {
            self.cnt = 100
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case plus
        case minus
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
                state.cnt = 100
            return .none
            
        case .plus:
            state.cnt = 5200
            return .none
        case .minus:
            state.cnt -= 1000
            return .none
            
        default:
            return .none
        }
    }
}
