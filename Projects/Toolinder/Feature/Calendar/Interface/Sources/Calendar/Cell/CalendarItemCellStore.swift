//
//  CalendarItemCellStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct CalendarItemCellStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        
        public let trades: [Trade]
        public let date: Date
        public var isSelected: Bool
        
        public var tradePreviewItem: IdentifiedArrayOf<TradePreviewItemCellStore.State> = []
        
        public init(
            id: UUID = .init(),
            trades: [Trade] = [],
            date: Date = .now,
            isSelected: Bool = false
        ) {
            self.id = id
            self.trades = trades
            self.date = date
            self.isSelected = isSelected
            
            self.tradePreviewItem = .init(
                uniqueElements: trades.map {
                    .init(trade: $0)
                }
            )
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case tradePreviewItem(id: TradePreviewItemCellStore.State.ID, action: TradePreviewItemCellStore.Action)
        
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