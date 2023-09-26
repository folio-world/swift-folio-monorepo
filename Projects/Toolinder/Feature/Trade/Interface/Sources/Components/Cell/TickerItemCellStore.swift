//
//  TickerItemCellStore.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TickerItemCellStore: Reducer {
    public init() {}
    
    public enum Mode {
        case preview
        case item
    }
    
    public struct State: Equatable, Identifiable {
        public let mode: Mode
        public let id: UUID
        public let ticker: Ticker
        public let tickerSummaryDataEntity: TickerSummaryDataEntity
        
        public var isSelected: Bool
        
        public init(
            mode: Mode = .item,
            id: UUID = .init(),
            ticker: Ticker,
            isSelected: Bool = false
        ) {
            self.mode = mode
            self.id = id
            self.ticker = ticker
            self.tickerSummaryDataEntity = ticker.toTickerSummaryDataEntity()
            
            self.isSelected = isSelected
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
