//
//  AddTickerStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import Foundation

import ComposableArchitecture

import ToolinderDomainTradeInterface

public struct TickerEditStore: Reducer {
    public init() {}
    
    public enum Mode {
        case add
        case edit
    }
    
    public struct State: Equatable {
        public var mode: Mode
        public var name: String = ""
        public var tickerType: TickerType?
        public var currency: Currency?
        public var tickers: [Ticker] = []
        
        public var selectedTicker: Ticker?
        
        @PresentationState var selectTickerType: SelectTickerTypeStore.State?
        @PresentationState var selectCurrency: SelectCurrencyStore.State?
        
        public init(
            mode: Mode = .add,
            selectedTicker: Ticker? = nil
        ) {
            self.mode = mode
            self.selectedTicker = selectedTicker
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setName(String)
        case tickerTapped(Ticker)
        case tickerTypeViewTapped
        case currencyViewTapped
        case nextButtonTapped
        
        case fetchTickersRequest
        case fetchTickersResponse([Ticker])
        
        case selectTickerType(PresentationAction<SelectTickerTypeStore.Action>)
        case selectCurrency(PresentationAction<SelectCurrencyStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case cancel
            case next(Ticker)
        }
    }
    
    @Dependency(\.tradeClient) var tradeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchTickersRequest)
                ])
                
            case let .setName(name):
                state.name = name
                return .none
                
            case let .tickerTapped(ticker):
                if ticker == state.selectedTicker {
                    state.selectedTicker = nil
                } else {
                    state.selectedTicker = ticker
                }
                
                return .none
                
            case .tickerTypeViewTapped:
                state.selectTickerType = .init()
                return .none
                
            case .currencyViewTapped:
                state.selectCurrency = .init()
                return .none
                
            case .nextButtonTapped:
                if let ticker = state.selectedTicker {
                    return .send(.delegate(.next(ticker)))
                }
                
                return validateAndSaveTickerEffect(
                    tickerType: state.tickerType,
                    currency: state.currency,
                    name: state.name
                )
                
            case .fetchTickersRequest:
                let tickers = (try? tradeClient.fetchTickers().get()) ?? []
                return .send(.fetchTickersResponse(tickers))
                
            case let .fetchTickersResponse(tickers):
                state.tickers = tickers
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
    
    private func validateAndSaveTickerEffect(tickerType: TickerType?, currency: Currency?, name: String) -> Effect<TickerEditStore.Action> {
        guard let tickerType = tickerType else { return .none }
        guard let currency = currency else { return .none }
        guard name.isEmpty == false else { return .none }
        
        if let ticker = try? tradeClient.saveTicker(.init(type: tickerType, currency: currency, name: name)).get() {
            return .send(.delegate(.next(ticker)))
        } else {
            return .none
        }
    }
}
