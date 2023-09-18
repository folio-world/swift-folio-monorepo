//
//  TradePreviewItemCellStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TradePreviewItemCellStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        
        public let trade: Trade
        
        public init(
            id: UUID = .init(),
            trade: Trade
        ) {
            self.id = id
            self.trade = trade
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
