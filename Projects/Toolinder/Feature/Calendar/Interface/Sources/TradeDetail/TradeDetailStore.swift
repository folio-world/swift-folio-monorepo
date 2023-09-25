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
        
        @PresentationState var addTrade: AddTradeStore.State?
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
        
        public init(trade: Trade) {
            self.trade = trade
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case editButtonTapped
        
        case addTrade(PresentationAction<AddTradeStore.Action>)
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
                    state.addTrade = .init(trade: state.trade, ticker: ticker)
                }
                return .none
                
            case let .addTrade(.presented(.delegate(.save(trade)))):
                state.trade = trade
                state.addTrade = nil
                return .none
                
            case let .addTrade(.presented(.delegate(.delete(trade)))):
                state.addTrade = nil
                return .send(.delegate(.delete(trade)))

            case .addTrade(.dismiss), .addTrade(.presented(.delegate(.cancel))), .addTrade(.presented(.delegate(.dismiss))):
                state.addTrade = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$addTrade, action: /Action.addTrade) {
            AddTradeStore()
        }
    }
}
