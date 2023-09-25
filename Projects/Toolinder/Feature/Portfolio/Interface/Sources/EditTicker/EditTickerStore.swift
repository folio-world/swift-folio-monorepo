//
//  EditTickerStore.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct EditTickerStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let ticker: Ticker
        
        public init(
            ticker: Ticker
        ) {
            self.ticker = ticker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
    }
}