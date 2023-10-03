//
//  AddTickerStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import Foundation

import ComposableArchitecture

import ToolinderDomainTradeInterface

public struct EditTickerStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var mode: EditMode
        public var ticker: Ticker?
        
        public var name: String = ""
        public var selectedTickerType: TickerType?
        public var selectedCurrency: Currency?
        public var selectedTags: [Tag] = [] {
            didSet {
                tagItem = .init(
                    uniqueElements: selectedTags.map { tag in
                        return .init(tag: tag)
                    }
                )
            }
        }
        
        public var tagItem: IdentifiedArrayOf<TagItemCellStore.State> = []
        @PresentationState var selectTickerType: SelectTickerTypeStore.State?
        @PresentationState var selectCurrency: SelectCurrencyStore.State?
        @PresentationState var selectTag: SelectTagStore.State?
        @PresentationState var alert: AlertState<Action.Alert>?
        
        public init(
            mode: EditMode = .add,
            ticker: Ticker? = nil
        ) {
            self.mode = mode
            self.ticker = ticker
            
            if mode == .edit {
                self.name = ticker?.name ?? ""
                self.selectedTickerType = ticker?.type ?? .stock
                self.selectedCurrency = ticker?.currency ?? .dollar
                self.tagItem = .init(
                    uniqueElements: ticker?.tags?.map { tag in
                        return .init(tag: tag)
                    } ?? []
                )
            }
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setName(String)
        case tickerTypeButtonTapped
        case currencyButtonTapped
        case tagButtonTapped
        case dismissButtonTapped
        case deleteButtonTapped
        case saveButtonTapped
        
        case tagItem(id: TagItemCellStore.State.ID, action: TagItemCellStore.Action)
        case selectTickerType(PresentationAction<SelectTickerTypeStore.Action>)
        case selectCurrency(PresentationAction<SelectCurrencyStore.Action>)
        case selectTag(PresentationAction<SelectTagStore.Action>)
        
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        
        public enum Alert: Equatable {
            case confirmDeletion
        }
        
        public enum Delegate: Equatable {
            case cancle
            case save(Ticker)
            case delete(Ticker)
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .setName(name):
                state.name = name
                return .none
                
            case .tickerTypeButtonTapped:
                state.selectTickerType = .init()
                return .none
                
            case .currencyButtonTapped:
                state.selectCurrency = .init()
                return .none
                
            case .tagButtonTapped:
                state.selectTag = .init(selectedTags: state.selectedTags)
                return .none
                
            case .dismissButtonTapped:
                return .send(.delegate(.cancle))
                
            case .deleteButtonTapped:
                state.alert = AlertState {
                    TextState("\(state.ticker?.trades?.count ?? 0) records are also deleted.")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion) {
                        TextState("Delete")
                    }
                }
                return .none
                
            case .saveButtonTapped:
                return validateAndSaveTickerEffect(
                    mode: state.mode,
                    ticker: state.ticker,
                    tickerType: state.selectedTickerType,
                    currency: state.selectedCurrency,
                    name: state.name
                )
                
            case let .selectTickerType(.presented(.delegate(.select(tickerType)))):
                state.selectTickerType = nil
                state.selectedTickerType = tickerType
                return .none
                
            case let .selectCurrency(.presented(.delegate(.select(currency)))):
                state.selectCurrency = nil
                state.selectedCurrency = currency
                return .none
                
            case .selectTickerType(.dismiss):
                state.selectTickerType = nil
                return .none
                
            case .selectCurrency(.dismiss):
                state.selectCurrency = nil
                return .none
                
            case .selectTag(.dismiss):
                state.selectTag = nil
                return .none
                
            case let .selectTag(.presented(.delegate(.select(tags)))):
                state.selectTag = nil
                state.selectedTags = tags
                return .none
                
            case .alert(.presented(.confirmDeletion)):
                if let ticker = state.ticker {
                    let _ = tickerClient.deleteTicker(ticker)
                    return .send(.delegate(.delete(ticker)))
                }
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$selectTag, action: /Action.selectTag) {
            SelectTagStore()
        }
        
        .ifLet(\.$alert, action: /Action.alert)
    }
    
    private func validateAndSaveTickerEffect(
        mode: EditMode,
        ticker: Ticker?,
        tickerType: TickerType?,
        currency: Currency?,
        name: String
    ) -> Effect<EditTickerStore.Action> {
        guard let tickerType = tickerType else { return .none }
        guard let currency = currency else { return .none }
        guard name.isEmpty == false else { return .none }
        
        switch mode {
        case .add:
            if let ticker = try? tickerClient.saveTicker(.init(type: tickerType, currency: currency, name: name, tags: [])).get() {
                return .send(.delegate(.save(ticker)))
            } else {
                return .none
            }
        case .edit:
            guard let ticker = ticker else { return .none }
            
            if let ticker = try? tickerClient.updateTicker(ticker, .init(type: tickerType, currency: currency, name: name, tags: [])).get() {
                return .send(.delegate(.save(ticker)))
            } else {
                return .none
            }
        default: return .none
        }
    }
}
