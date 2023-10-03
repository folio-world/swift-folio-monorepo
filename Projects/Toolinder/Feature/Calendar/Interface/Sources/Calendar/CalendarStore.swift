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
        public var calendars: [CalendarEntity] {
            didSet {
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
        
        public var selectedDate: Date
        public var selectedCalendar: CalendarEntity?
        
        public var selectedCalendarItemID: CalendarItemCellStore.State.ID?
        
        public var calendarItem: IdentifiedArrayOf<CalendarItemCellStore.State> = []
        public var tradeItem: IdentifiedArrayOf<TradeItemCellStore.State> = []
        @PresentationState var selectTicker: SelectTickerStore.State?
        @PresentationState var editTrade: EditTradeStore.State?
        
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
        case refreshScroll
        
        case refreshTradeItem([Trade])
        
        case calendarItem(id: CalendarItemCellStore.State.ID, action: CalendarItemCellStore.Action)
        case tradeItem(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        case selectTicker(PresentationAction<SelectTickerStore.Action>)
        case editTrade(PresentationAction<EditTradeStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case refresh
            case detail(Trade)
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                if let id = state.selectedCalendarItemID {
                    return .send(.refreshTradeItem(state.calendarItem[id: id]?.trades ?? []))
                }
                return .none
                
            case .newButtonTapped:
                state.selectTicker = .init()
                return .none
                
            case let .tradeItemTapped(trade):
                return .send(.delegate(.detail(trade)))
                
            case .refreshScroll:
                return .send(.delegate(.refresh))
                
            case let .refreshTradeItem(trades):
                state.tradeItem = .init(
                    uniqueElements: trades.map { trade in
                        return .init(
                            trade: trade,
                            dateStyle: .short,
                            timeStyle: .short
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
                
            case let .selectTicker(.presented(.delegate(.select(ticker)))):
                state.selectTicker = nil
                state.editTrade = .init(selectedTicker: ticker, selectedDate: state.selectedDate)
                return .none
                
            case .selectTicker(.dismiss):
                state.selectTicker = nil
                return .none
                
            case .editTrade(.presented(.delegate(.save))):
                state.selectTicker = nil
                state.editTrade = nil
                return .none
                
            case let .editTrade(.presented(.delegate(.cancel(ticker)))):
                state.selectTicker = .init(selectedTicker: ticker)
                state.editTrade = nil
                return .none
                
            case .editTrade(.dismiss):
                state.editTrade = nil
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
        .ifLet(\.$selectTicker, action: /Action.selectTicker) {
            SelectTickerStore()
        }
        .ifLet(\.$editTrade, action: /Action.editTrade) {
            EditTradeStore()
        }
    }
}
