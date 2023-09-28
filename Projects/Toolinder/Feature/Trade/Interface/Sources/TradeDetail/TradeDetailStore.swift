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
        
        @PresentationState var tradeEdit: TradeEditStore.State?
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
        
        public init(trade: Trade) {
            self.trade = trade
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case editButtonTapped
        case newButtonTapped
        
        case tradeEdit(PresentationAction<TradeEditStore.Action>)
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
                    uniqueElements: state.trade.ticker?.trades.compactMap { trade in
                        return .init(trade: trade, dateStyle: .short, timeStyle: .short)
                    } ?? []
                )
                return .none
                
            case .editButtonTapped:
                if let ticker = state.trade.ticker {
                    state.tradeEdit = .init(selectedTicker: ticker, selectedTrade: state.trade)
                }
                return .none
                
            case .newButtonTapped:
                if let ticker = state.trade.ticker {
                    state.tradeEdit = .init(selectedTicker: ticker)
                }
                return .none
                
            case let .tradeEdit(.presented(.delegate(.save(trade)))):
                state.trade = trade
                state.tradeEdit = nil
                return .none
                
            case let .tradeEdit(.presented(.delegate(.delete(trade)))):
                state.tradeEdit = nil
                return .send(.delegate(.delete(trade)))

            case .tradeEdit(.dismiss), .tradeEdit(.presented(.delegate(.cancel))):
                state.tradeEdit = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$tradeEdit, action: /Action.tradeEdit) {
            TradeEditStore()
        }
    }
}
