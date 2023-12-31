//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trades: [Trade] = []
        public var selectedDate: Date = .now
        public var currentTab: Int = 0
        
        public var calendars: IdentifiedArrayOf<CalendarStore.State> = []
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        case fetch
        
        case selectTab(Int)
        
        case fetched([Trade])
        case refreshCalendar(Date, [Trade])
        
        case calendar(id: CalendarStore.State.ID, action: CalendarStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case detail(Trade)
        }
    }
    
    @Dependency(\.tradeClient) var tradeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetch)
                
            case .fetch:
                if let trades = try? tradeClient.fetchTrades().get() {
                    return .send(.fetched(trades))
                } else {
                    return .none
                }
                
            case let .selectTab(tab):
                switch tab {
                case state.calendars.first?.offset:
                    let offset = tab - 1
                    let date = Date.now.add(byAdding: .month, value: offset)
                    let calendarEntities = CalendarEntity.toDomain(date: date, trades: state.trades)
                    let calendarState = CalendarStore.State(
                        offset: offset,
                        calendars: calendarEntities,
                        selectedDate: date
                    )
                    state.calendars.insert(calendarState, at: 0)
                case state.calendars.last?.offset:
                    let offset = tab + 1
                    let date = Date.now.add(byAdding: .month, value: offset)
                    let calendarEntities = CalendarEntity.toDomain(date: date, trades: state.trades)
                    let calendarState = CalendarStore.State(
                        offset: offset,
                        calendars: calendarEntities,
                        selectedDate: .now.add(byAdding: .month, value: offset)
                    )
                    state.calendars.append(calendarState)
                default: break
                }
                state.currentTab = tab
                return .none
                
            case let .fetched(trades):
                state.trades = trades
                return .send(.refreshCalendar(state.selectedDate, trades))
                
            case let .refreshCalendar(date, trades):
                if state.calendars.isEmpty {
                    let prevDate = date.add(byAdding: .month, value: -1)
                    let nextDate = date.add(byAdding: .month, value: 1)
                    state.calendars = [
                        .init(
                            offset: -1,
                            calendars: CalendarEntity.toDomain(date: prevDate, trades: trades),
                            selectedDate: prevDate
                        ),
                        .init(
                            offset: 0,
                            calendars: CalendarEntity.toDomain(date: date, trades: trades),
                            selectedDate: .now
                        ),
                        .init(
                            offset: 1,
                            calendars: CalendarEntity.toDomain(date: nextDate, trades: trades),
                            selectedDate: nextDate
                        )
                    ]
                } else {
                    for id in state.calendars.ids {
                        let date = state.calendars[id: id]?.selectedDate ?? .now
                        state.calendars[id: id]?.calendars = CalendarEntity.toDomain(date: date, trades: trades)
                    }
                }
                
                return .none
                
            case let .calendar(id, action):
                switch action {
                case .delegate(.refresh):
                    return .send(.fetch)
                    
                case .editTrade(.presented(.delegate(.save))):
                    return .send(.fetch)
                    
                case .editTrade(.dismiss):
                    return .send(.fetch)
                    
                case let .delegate(.detail(trade)):
                    return .send(.delegate(.detail(trade)))
                    
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        
        .forEach(\.calendars, action: /Action.calendar(id:action:)) {
            CalendarStore()
        }
    }
}
