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
                
            case .addTicker(.dismiss):
                state.addTicker = nil
                return .none
                
            case .addTicker(.presented(.delegate(.cancel))):
                state.addTicker = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$addTicker, action: /Action.addTicker) {
            AddTickerStore()
        }
    }
}
