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
        public init() {}
    }
    
    public enum Action: Equatable {
        
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
    }
}
