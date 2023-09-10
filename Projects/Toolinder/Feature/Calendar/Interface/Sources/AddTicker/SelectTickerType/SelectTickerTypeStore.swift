//
//  SelectTickerTypeStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/10.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct SelectTickerTypeStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tickerTypeTapped(TickerType)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(TickerType)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .tickerTypeTapped(tickerType):
                return .send(.delegate(.select(tickerType)))
                
            default:
                return .none
            }
        }
    }
}
