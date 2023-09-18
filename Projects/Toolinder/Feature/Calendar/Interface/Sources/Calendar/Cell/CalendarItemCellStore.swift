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
    static let PREVIEW_CELL_MAX_LENGTH = 3
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        
        public let trades: [Trade]
        public let date: Date
        public var isSelected: Bool {
            didSet {
                self.tradePreviewItem.ids.forEach { id in
                    self.tradePreviewItem[id: id]?.isSelected = isSelected
                }
            }
        }
        
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
                uniqueElements: 
                    self.trades.map {
                        .init(trade: $0, isSelected: isSelected)
                    }
                    .suffix(PREVIEW_CELL_MAX_LENGTH)
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
