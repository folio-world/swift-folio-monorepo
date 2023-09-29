//
//  TickerDetailStore.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TickerDetailStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let ticker: Ticker
        
        public var tradeDateChartDataEntity: TradeDateChartDataEntity = .init()
        
        @PresentationState var tickerEdit: TickerEditStore.State?
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
        
        public init(
            ticker: Ticker
        ) {
            self.ticker = ticker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case editButtonTapped
        
        case tickerTypeChartDataEntityRequest
        case tickerTypeChartDataEntityResponse(TradeDateChartDataEntity)
        
        case tickerEdit(PresentationAction<TickerEditStore.Action>)
        case tradeItem(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case deleted
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.tradeItem = .init(
                    uniqueElements: state.ticker.trades?.sorted(by: { $0.date < $1.date }).compactMap { trade in
                        return .init(trade: trade, dateStyle: .short, timeStyle: .short)
                    } ?? []
                )
                return .concatenate([
                    .send(.tickerTypeChartDataEntityRequest)
                ])
                
            case .editButtonTapped:
                state.tickerEdit = .init(mode: .edit, selectedTicker: state.ticker)
                return .none
                
            case .tickerTypeChartDataEntityRequest:
                return .send(
                    .tickerTypeChartDataEntityResponse(
                        state.ticker.trades?.toTradeDateChartDataEntity(
                            from: .now.add(byAdding: .month, value: -1),
                            to: .now.add(byAdding: .month, value: 1))
                        ?? []
                    )
                )
                
            case let .tickerTypeChartDataEntityResponse(entity):
                state.tradeDateChartDataEntity = entity
                return .none
                
            case .tickerEdit(.presented(.delegate(.delete))):
                state.tickerEdit = nil
                return .send(.delegate(.deleted))
                
            case .tickerEdit(.dismiss):
                state.tickerEdit = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$tickerEdit, action: /Action.tickerEdit) {
            TickerEditStore()
        }
    }
}
