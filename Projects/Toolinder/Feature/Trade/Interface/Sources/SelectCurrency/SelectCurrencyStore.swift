//
//  SelectCurrencyStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/10.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct SelectCurrencyStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case currencyTapped(Currency)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(Currency)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .currencyTapped(currency):
                return .send(.delegate(.select(currency)))
                
            default:
                return .none
            }
        }
    }
}
