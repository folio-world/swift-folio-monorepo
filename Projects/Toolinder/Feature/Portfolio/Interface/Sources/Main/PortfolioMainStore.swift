//
//  PortfolioMainStore.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation

import ComposableArchitecture

public struct PortfolioMainStore: Reducer {
    public init() {}
    
    public enum Period: String, CaseIterable {
        case whole = "Whole"
        case month = "Month"
        case week = "Week"
        case day = "Day"
    }
    
    public struct State: Equatable {
        public var selectedPeriod: Period = .whole
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectPeriod(Period)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .selectPeriod(period):
                state.selectedPeriod = period
                return .none
                
            default:
                return .none
            }
        }
    }
}
