//
//  MyPageNavigationStackStore.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/08/28.
//

import ComposableArchitecture

import ToolinderFeatureTradeInterface

public struct PortfolioNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: PortfolioMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(PortfolioMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case tickerDetail(TickerDetailStore.State)
        }
        
        public enum Action: Equatable {
            case tickerDetail(TickerDetailStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.tickerDetail, action: /Action.tickerDetail) {
                TickerDetailStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .main(.delegate(.tickerDetail(ticker))):
                state.path.append(.tickerDetail(.init(ticker: ticker)))
                return .none
                
            case let .path(.element(id: id, action: .tickerDetail(.delegate(.deleted)))):
                state.path[id: id] = nil
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            PortfolioMainStore()._printChanges()
        }
        
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
