//
//  TradeDetailStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation

import ComposableArchitecture

import ToolinderFeatureTradeInterface
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
                    uniqueElements: state.trade.ticker?.trades?.compactMap { trade in
                        return .init(trade: trade, dateStyle: .short, timeStyle: .none)
                    } ?? []
                )
                return .none
                
            case .editButtonTapped:
                if let ticker = state.trade.ticker {
                    state.editTrade = .init(trade: state.trade, ticker: ticker)
                }
                return .none
                
            case let .editTrade(.presented(.delegate(.save(trade)))):
                state.trade = trade
                state.editTrade = nil
                return .none
                
            case let .editTrade(.presented(.delegate(.delete(trade)))):
                state.editTrade = nil
                return .send(.delegate(.delete(trade)))

            case .editTrade(.dismiss), .editTrade(.presented(.delegate(.cancel))), .editTrade(.presented(.delegate(.dismiss))):
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
