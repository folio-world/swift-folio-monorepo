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
    
    public struct State: Equatable {
        public var calendars: [CalendarEntity]
        public var selectedDate: Date
        
        public init(
            calendars: [CalendarEntity],
            selectedDate: Date
        ) {
            self.calendars = calendars
            self.selectedDate = selectedDate
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tap
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        default:
            return .none
        }
    }
}
