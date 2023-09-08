//
//  AddTickerStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct AddTickerStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var name: String = ""
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setName(String)
        
        case delegate(Delegate)
        
        public enum Delegate {
            case cancel
        }
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action>  {
        switch action {
        case .onAppear:
            return .none
            
        case let .setName(name):
            state.name = name
            return .none
            
        default:
            return .none
        }
    }
}
