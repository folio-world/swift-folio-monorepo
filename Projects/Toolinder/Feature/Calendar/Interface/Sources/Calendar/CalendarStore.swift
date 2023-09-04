//
//  CalendarStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/04.
//

import ComposableArchitecture

import ToolinderDomain

public struct CalendarStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
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
