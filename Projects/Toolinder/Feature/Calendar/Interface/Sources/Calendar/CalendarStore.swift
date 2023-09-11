//
//  CalendarStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct CalendarStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public var id: UUID
        public var offset: Int
        public var calendars: [CalendarEntity]
        public var selectedDate: Date
        
        @PresentationState var addTicker: AddTickerStore.State?
        @PresentationState var addTrade: AddTradeStore.State?
        
        public init(
            id: UUID = .init(),
            offset: Int,
            calendars: [CalendarEntity],
            selectedDate: Date
        ) {
            self.id = id
            self.offset = offset
            self.calendars = calendars
            self.selectedDate = selectedDate
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectDate(Date)
        case newButtonTapped
        
        case addTicker(PresentationAction<AddTickerStore.Action>)
        case addTrade(PresentationAction<AddTradeStore.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .selectDate(date):
                state.selectedDate = date
                return .none
                
            case .newButtonTapped:
                state.addTicker = .init()
                return .none
                
            case .addTicker(.presented(.delegate(.cancel))):
                state.addTicker = nil
                return .none
                
            case let .addTicker(.presented(.delegate(.next(ticker)))):
                state.addTicker = nil
                state.addTrade = .init(ticker: ticker)
                return .none
                
            case .addTicker(.dismiss):
                state.addTicker = nil
                return .none
                
            case .addTrade(.presented(.delegate(.save))):
                state.addTicker = nil
                state.addTrade = nil
                return .none
                
            case let .addTrade(.presented(.delegate(.cancel(ticker)))):
                state.addTicker = .init(selectedTicker: ticker)
                state.addTrade = nil
                return .none
                
            case .addTrade(.dismiss), .addTrade(.presented(.delegate(.dismiss))):
                state.addTrade = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$addTicker, action: /Action.addTicker) {
            AddTickerStore()
        }
        .ifLet(\.$addTrade, action: /Action.addTrade) {
            AddTradeStore()
        }
    }
}
