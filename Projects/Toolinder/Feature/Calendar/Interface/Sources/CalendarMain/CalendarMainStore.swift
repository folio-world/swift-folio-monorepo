//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import ComposableArchitecture

import ToolinderDomain

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trades: [Trade] = []
        
        public var calendar: CalendarStore.State = .init()
        public var prevCalendar: CalendarStore.State = .init()
        public var nextCalendar: CalendarStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetched([Trade])
        
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
