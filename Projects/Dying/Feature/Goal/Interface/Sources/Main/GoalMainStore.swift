//
//  GoalMainStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

public struct GoalMainStore: Reducer {
    public init() {}
    
    public enum Unit: String, CaseIterable, Equatable, Codable, Hashable {
        case year
        case month
        
        var number: Int {
            switch self {
            case .year: return 100
            case .month: return 1200
            }
        }
    }
    
    public struct State: Codable, Equatable, Hashable {
        var pointNumber: Int = 100
        var currentUnit: Unit = .year
        
        public init() {
            
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectUnit(Unit)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        case let .selectUnit(unit):
            state.currentUnit = unit
            state.pointNumber = unit.number
            return .none
            
        default:
            return .none
        }
    }
}
