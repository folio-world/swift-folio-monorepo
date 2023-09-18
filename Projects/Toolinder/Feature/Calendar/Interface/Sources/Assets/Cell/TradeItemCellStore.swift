//
//  TradeItemCellStore.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TradeItemCellStore: Reducer {
    public init() {}
    
    public enum ViewType {
        case `default`
        case edit
    }
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public let trade: Trade
        
        public let viewType: ViewType
        public let dateStyle: DateFormatter.Style
        public let timeStyle: DateFormatter.Style
        
        public var isSelected: Bool
        public init(
            id: UUID = .init(),
            trade: Trade,
            viewType: ViewType = .default,
            dateStyle: DateFormatter.Style,
            timeStyle: DateFormatter.Style,
            isSelected: Bool
        ) {
            self.id = id
            self.trade = trade
            self.viewType = viewType
            self.dateStyle = dateStyle
            self.timeStyle = timeStyle
            self.isSelected = isSelected
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        case editButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
            case editButtonTapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            case .editButtonTapped:
                return .send(.delegate(.editButtonTapped))
                
            default:
                return .none
            }
        }
    }
}
