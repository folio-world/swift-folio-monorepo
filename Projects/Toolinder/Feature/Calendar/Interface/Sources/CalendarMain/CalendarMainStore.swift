//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import ComposableArchitecture

import ToolinderDomain

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trades: [Trade] = []
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetched([Trade])
        
        case goToGoalDetail(GoalDetailStore.State)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        case let .fetched(trades):
            state.trades = trades
            return .none
            
        default:
            return .none
        }
    }
}
