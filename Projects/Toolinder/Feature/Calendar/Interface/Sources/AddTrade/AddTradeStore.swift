//
//  AddPriceStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/08.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct AddTradeStore: Reducer {
    public init() {}
    
    @Dependency(\.tradeClient) var tradeClient
    
    public struct State: Equatable {
        public var ticker: Ticker
        
        public var count: Double = .zero
        public var price: Double = .zero
        public var selectedDate: Date = .now
        public var selectedTradeSide: TradeSide = .buy
        
        public init(ticker: Ticker) {
            self.ticker = ticker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setCount(Double)
        case setPrice(Double)
        case selectDate(Date)
        case selectTradeSide(TradeSide)
        case dismissButtonTapped
        case cancleButtonTapped
        case saveButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case dismiss
            case cancel(Ticker)
            case save(Trade)
        }
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        case let .setCount(count):
            state.count = count
            return .none
            
        case let .setPrice(price):
            state.price = price
            return .none
            
        case let .selectDate(date):
            state.selectedDate = date
            return .none
            
        case let .selectTradeSide(tradeSide):
            state.selectedTradeSide = tradeSide
            return .none
            
        case .dismissButtonTapped:
            return .send(.delegate(.cancel(state.ticker)))
            
        case .cancleButtonTapped:
            return .send(.delegate(.dismiss))
            
        case .saveButtonTapped:
            return validateAndSaveTradeEffect(
                side: state.selectedTradeSide,
                price: state.price,
                volume: state.count,
                images: [], note: "",
                date: state.selectedDate,
                ticker: state.ticker
            )
            
        default:
            return .none
        }
    }
    
    private func validateAndSaveTradeEffect(
        side: TradeSide,
        price: Double,
        volume: Double,
        images: [Data],
        note: String,
        date: Date,
        ticker: Ticker?
    ) -> Effect<AddTradeStore.Action> {
        guard let ticker = ticker else { return .none }
        guard !price.isZero else { return .none }
        guard !volume.isZero else { return .none }
        
        if let trade = try? tradeClient.saveTrade(.init(
            side: side,
            price: price,
            volume: volume,
            images: images,
            note: note,
            date: date,
            ticker: ticker
        )).get() {
            return .send(.delegate(.save(trade)))
        } else {
            return .none
        }
    }
}
