//
//  CalendarStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain
import ToolinderFeatureTradeInterface

public struct CalendarStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public var id: UUID
        public var offset: Int
        public var calendars: [CalendarEntity]
        
        public var selectedDate: Date
        public var selectedCalendar: CalendarEntity?
        
        public var selectedCalendarItemID: CalendarItemCellStore.State.ID?
        
        public var calendarItem: IdentifiedArrayOf<CalendarItemCellStore.State> = []
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
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
            self.calendarItem = .init(uniqueElements: calendars.map { calendar in
                let id = UUID()
                let isSelected = calendar.date.isEqual(date: selectedDate)
                if isSelected {
                    self.selectedCalendarItemID = id
                }
                return .init(
                    id: id,
                    trades: calendar.trades,
                    date: calendar.date,
                    isSelected: isSelected
                )
            })
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case newButtonTapped
        case tradeItemTapped(Trade)
        
        case refreshTradeItem([Trade])
        
        case calendarItem(id: CalendarItemCellStore.State.ID, action: CalendarItemCellStore.Action)
        case tradeItem(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        case addTicker(PresentationAction<AddTickerStore.Action>)
        case addTrade(PresentationAction<AddTradeStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case detail(Trade)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .newButtonTapped:
                state.addTicker = .init()
                return .none
                
            case let .tradeItemTapped(trade):
                return .send(.delegate(.detail(trade)))
                
            case let .refreshTradeItem(trades):
                state.tradeItem = .init(
                    uniqueElements: trades.map { trade in
                        return .init(
                            trade: trade,
                            dateStyle: .short,
                            timeStyle: .none
                        )
                    }
                )
                return .none
                
            case let .calendarItem(id, action: .delegate(.tapped)):
                if let prevSelectedCalendarItemID = state.selectedCalendarItemID {
                    state.calendarItem[id: prevSelectedCalendarItemID]?.isSelected = false
                }
                state.selectedCalendarItemID = id
                state.calendarItem[id: id]?.isSelected = true
                state.selectedDate = state.calendarItem[id: id]?.date ?? .now
                let selectedTrades: [Trade] = state.calendarItem[id: id]?.trades ?? []
                return .send(.refreshTradeItem(selectedTrades))
                
            case let .tradeItem(id, action: .delegate(.tapped)):
                if let trade = state.tradeItem[id: id]?.trade {
                    return .send(.delegate(.detail(trade)))
                } else {
                    return .none
                }
                
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
        .forEach(\.calendarItem, action: /Action.calendarItem(id:action:)) {
            CalendarItemCellStore()
        }
        .forEach(\.tradeItem, action: /Action.tradeItem(id:action:)) {
            TradeItemCellStore()
        }
        .ifLet(\.$addTicker, action: /Action.addTicker) {
            AddTickerStore()
        }
        .ifLet(\.$addTrade, action: /Action.addTrade) {
            AddTradeStore()
        }
    }
}
