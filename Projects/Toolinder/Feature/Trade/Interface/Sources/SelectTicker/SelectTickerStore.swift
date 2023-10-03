//
//  SelectTickerStore.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain

public struct SelectTickerStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var tickerItem: IdentifiedArrayOf<TickerItemCellStore.State> = []
        
        public var selectedTicker: Ticker?
        
        @PresentationState var editTicker: EditTickerStore.State?
        
        public init(selectedTicker: Ticker? = nil) {
            self.selectedTicker = selectedTicker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case addButtonTapped
        
        case fetchTickersRequest
        case fetchTickersResponse([Ticker])
        
        case tickerItem(id: TickerItemCellStore.State.ID, action: TickerItemCellStore.Action)
        case editTicker(PresentationAction<EditTickerStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select(Ticker)
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchTickersRequest)
                
            case .addButtonTapped:
                state.editTicker = .init()
                return .none
                
            case .fetchTickersRequest:
                let tags = (try? tickerClient.fetchTickers().get()) ?? []
                return .send(.fetchTickersResponse(tags))
                
            case let .fetchTickersResponse(tickers):
                state.tickerItem = .init(
                    uniqueElements: tickers.map { ticker in
                        .init(
                            mode: .preview,
                            ticker: ticker,
                            isSelected: state.selectedTicker == ticker
                        )
                    }
                )
                return .none
                
            case .editTicker(.presented(.delegate(.save))):
                return .send(.fetchTickersRequest)
                
            case .editTicker(.dismiss), .editTicker(.presented(.delegate(.cancle))):
                state.editTicker = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$editTicker, action: /Action.editTicker) {
            EditTickerStore()
        }
    }
}
