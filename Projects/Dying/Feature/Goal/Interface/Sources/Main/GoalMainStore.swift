//
//  GoalMainStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import Foundation

import ComposableArchitecture

public struct GoalMainStore: Reducer {
    public init() {}
    
    public enum Unit: String, CaseIterable, Equatable, Codable, Hashable {
        case year
        case month
        case week
        
        var number: Int {
            switch self {
            case .year: return 100
            case .month: return 1200
            case .week: return 5200
            }
        }
    }
    
    public struct State: Equatable {
        var pointNumber: Int = 100
        var currentDate: Date = .init()
        var currentUnit: Unit = .year
        
        public init() {
            
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectDate(Date)
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
