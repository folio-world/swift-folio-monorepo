//
//  TradeDetailStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TradeDetailStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trade: Trade
        
        public init(trade: Trade) {
            self.trade = trade
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case dismiss
            case cancel(Ticker)
            case save(Trade)
        }
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
