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
        
        @PresentationState var editTrade: EditTradeStore.State?
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
        
        public init(trade: Trade) {
            self.trade = trade
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case editButtonTapped
        case newButtonTapped
        
        case editTrade(PresentationAction<EditTradeStore.Action>)
        case tradeItem(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case delete(Trade)
            case cancel(Ticker)
            case save(Trade)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.tradeItem = .init(
                    uniqueElements: state.trade.ticker?.trades?.sorted(by: { $0.date < $1.date }).compactMap { trade in
                        return .init(trade: trade, dateStyle: .short, timeStyle: .short)
                    } ?? []
                )
                return .none
                
            case .editButtonTapped:
                if let ticker = state.trade.ticker {
                    state.editTrade = .init(mode: .edit, selectedTicker: ticker, selectedTrade: state.trade)
                }
                return .none
                
            case .newButtonTapped:
                if let ticker = state.trade.ticker {
                    state.editTrade = .init(mode: .bypassAdd, selectedTicker: ticker)
                }
                return .none
                
            case let .editTrade(.presented(.delegate(.save(trade)))):
                state.trade = trade
                state.editTrade = nil
                return .none
                
            case let .editTrade(.presented(.delegate(.delete(trade)))):
                state.editTrade = nil
                return .send(.delegate(.delete(trade)))

            case .editTrade(.dismiss), .editTrade(.presented(.delegate(.cancel))):
                state.editTrade = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$editTrade, action: /Action.editTrade) {
            EditTradeStore()
        }
    }
}
