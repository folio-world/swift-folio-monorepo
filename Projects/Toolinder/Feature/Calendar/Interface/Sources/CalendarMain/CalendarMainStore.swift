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
        
        public var calendar: CalendarStore.State = .init(calendars: [], selectedDate: .now)
        public var prevCalendar: CalendarStore.State = .init(calendars: [], selectedDate: .now.add(byAdding: .month, value: -1))
        public var nextCalendar: CalendarStore.State = .init(calendars: [], selectedDate: .now.add(byAdding: .month, value: 1))
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetched([Trade])
        case refreshCalendar(Date, [Trade])
        
        case calendar(CalendarStore.Action)
        case prevCalendar(CalendarStore.Action)
        case nextCalendar(CalendarStore.Action)
        
        case goToGoalDetail(GoalDetailStore.State)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
                return .none
                
            case let .fetched(trades):
                return .send(.refreshCalendar(state.selectedDate, trades))
                
            case let .refreshCalendar(date, trades):
                let prevDate = date.add(byAdding: .month, value: -1)
                let nextDate = date.add(byAdding: .month, value: 1)
                
                state.calendar = .init(
                    calendars: CalendarEntity.toDomain(date: date, trades: trades),
                    selectedDate: date
                )
                state.prevCalendar = .init(
                    calendars: CalendarEntity.toDomain(date: prevDate, trades: trades),
                    selectedDate: prevDate
                )
                state.nextCalendar = .init(
                    calendars: CalendarEntity.toDomain(date: nextDate, trades: trades),
                    selectedDate: nextDate
                )
                return .none
                
            default:
                return .none
            }
        }

        Scope(state: \.calendar, action: /Action.calendar) {
            CalendarStore()._printChanges()
        }
        Scope(state: \.prevCalendar, action: /Action.prevCalendar) {
            CalendarStore()._printChanges()
        }
        Scope(state: \.nextCalendar, action: /Action.nextCalendar) {
            CalendarStore()._printChanges()
        }
    }
}
