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
//        public var tickers: [Ticker] = []
        
        public var selectedTicker: Ticker?
        
        public var tickerItem: IdentifiedArrayOf<TickerItemCellStore.State> = []
        @PresentationState var selectTickerType: SelectTickerTypeStore.State?
        @PresentationState var selectCurrency: SelectCurrencyStore.State?
        @PresentationState var alert: AlertState<Action.Alert>?
        
        public init(
            mode: Mode = .add,
            selectedTicker: Ticker? = nil
        ) {
            self.mode = mode
            self.selectedTicker = selectedTicker
            
            if mode == .edit {
                self.name = selectedTicker?.name ?? ""
                self.tickerType = selectedTicker?.type ?? .stock
                self.currency = selectedTicker?.currency ?? .dollar
            }
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setName(String)
        case tickerTapped(Ticker)
        case tickerTypeViewTapped
        case currencyViewTapped
        case deleteButtonTapped
        case nextButtonTapped
        
        case fetchTickersRequest
        case fetchTickersResponse([Ticker])
        
        case tickerItem(id: TickerItemCellStore.State.ID, action: TickerItemCellStore.Action)
        case selectTickerType(PresentationAction<SelectTickerTypeStore.Action>)
        case selectCurrency(PresentationAction<SelectCurrencyStore.Action>)
        
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        
        public enum Alert: Equatable {
            case confirmDeletion
        }
        
        public enum Delegate: Equatable {
            case cancel
            case next(Ticker)
            case save(Ticker)
            case delete(Ticker)
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    
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
                
            case .deleteButtonTapped:
                state.alert = AlertState {
                    TextState("\(state.selectedTicker?.trades?.count ?? 0) records are also deleted.")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion) {
                        TextState("Delete")
                    }
                }
                return .none
                
            case .nextButtonTapped:
                if let ticker = state.selectedTicker, state.mode == .add {
                    return .send(.delegate(.next(ticker)))
                }
                
                return validateAndSaveTickerEffect(
                    mode: state.mode,
                    ticker: state.selectedTicker,
                    tickerType: state.tickerType,
                    currency: state.currency,
                    name: state.name
                )
                
            case .fetchTickersRequest:
                let tickers = (try? tickerClient.fetchTickers().get()) ?? []
                return .send(.fetchTickersResponse(tickers))
                
            case let .fetchTickersResponse(tickers):
                state.tickerItem = .init(uniqueElements: tickers.map { .init(mode: .preview, ticker: $0) })
                return .none
                
            case let .tickerItem(id: id, action: .delegate(.tapped)):
                let isSelected = state.tickerItem[id: id]?.isSelected ?? false
                
                for id in state.tickerItem.ids {
                    state.tickerItem[id: id]?.isSelected = false
                }
                
                state.tickerItem[id: id]?.isSelected = !isSelected
                
                if !isSelected {
                    state.selectedTicker = state.tickerItem[id: id]?.ticker
                } else {
                    state.selectedTicker = nil
                }
                
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
                
            case .alert(.presented(.confirmDeletion)):
                if let ticker = state.selectedTicker {
                    let _ = tickerClient.deleteTicker(ticker)
                    return .send(.delegate(.delete(ticker)))
                }
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.tickerItem, action: /Action.tickerItem(id:action:)) {
            TickerItemCellStore()
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
    
    private func validateAndSaveTickerEffect(
        mode: Mode,
        ticker: Ticker?,
        tickerType: TickerType?,
        currency: Currency?,
        name: String
    ) -> Effect<TickerEditStore.Action> {
        guard let tickerType = tickerType else { return .none }
        guard let currency = currency else { return .none }
        guard name.isEmpty == false else { return .none }
        
        switch mode {
        case .add:
            if let ticker = try? tickerClient.saveTicker(.init(type: tickerType, currency: currency, name: name)).get() {
                return .send(.delegate(.next(ticker)))
            } else {
                return .none
            }
        case .edit:
            guard let ticker = ticker else { return .none }
            
            if let ticker = try? tickerClient.updateTicker(ticker, .init(type: tickerType, currency: currency, name: name)).get() {
                return .send(.delegate(.save(ticker)))
            } else {
                return .none
            }
        }
    }
}
