//
//  AddTickerStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain
import ToolinderDomainTradeInterface

public struct AddTickerStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var name: String = ""
        public var tickerType: TickerType?
        public var currency: Currency?
        public var tickers: [Ticker] = []
        
        public var newTicker: Ticker?
        
        @PresentationState var selectTickerType: SelectTickerTypeStore.State?
        @PresentationState var selectCurrency: SelectCurrencyStore.State?
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetched([Ticker])
        
        case setName(String)
        case tickerTypeViewTapped
        case currencyViewTapped
        case nextButtonTapped
        
        case selectTickerType(PresentationAction<SelectTickerTypeStore.Action>)
        case selectCurrency(PresentationAction<SelectCurrencyStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case cancel
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .fetched(tickers):
                state.tickers = tickers
                return .none
                
            case let .setName(name):
                state.name = name
                return .none
                
            case .tickerTypeViewTapped:
                state.selectTickerType = .init()
                return .none
                
            case .currencyViewTapped:
                state.selectCurrency = .init()
                return .none
                
            case .nextButtonTapped:
                guard let tickerType = state.tickerType else { return .none }
                guard let currency = state.currency else { return .none }
                guard state.name.isEmpty == false else { return .none }
                
                state.newTicker = .init(type: tickerType, currency: currency, name: state.name)
                return .none
                
            case let .selectTickerType(.presented(.delegate(.select(tickerType)))):
                state.selectTickerType = nil
                state.tickerType = tickerType
                return .none
                
            case .selectTickerType(.dismiss):
                state.selectTickerType = nil
                return .none
                
            case let .selectCurrency(.presented(.delegate(.select(currency)))):
                state.selectCurrency = nil
                state.currency = currency
                return .none
                
            case .selectCurrency(.dismiss):
                state.selectCurrency = nil
                return .none
                
            default:
                return .none
            }
        }
    }
}
