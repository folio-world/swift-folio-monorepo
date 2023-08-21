//
//  GoalDetailStore.swift
//  DyingFeatureGoalDemo
//
//  Created by 송영모 on 2023/08/08.
//

import Foundation

import ComposableArchitecture

public struct GoalDetailStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {
            
        }
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        default:
            return .none
        }
    }
}
