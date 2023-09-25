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
        
        @PresentationState var editTicker: EditTickerStore.State?
        
        public init(
            ticker: Ticker
        ) {
            self.ticker = ticker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tickerTypeChartDataEntityRequest
        case tickerTypeChartDataEntityResponse(TradeDateChartDataEntity)
        
        case editTicker(PresentationAction<EditTickerStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.tickerTypeChartDataEntityRequest)
                ])
                
            case .tickerTypeChartDataEntityRequest:
                return .send(
                    .tickerTypeChartDataEntityResponse(
                        state.ticker.trades?.toDomain(
                            from: .now.add(byAdding: .month, value: -1),
                            to: .now.add(byAdding: .month, value: 1))
                        ?? []
                    )
                )
                
            case let .tickerTypeChartDataEntityResponse(entity):
                state.tradeDateChartDataEntity = entity
                return .none
                
            default:
                return .none
            }
        }
    }
}
