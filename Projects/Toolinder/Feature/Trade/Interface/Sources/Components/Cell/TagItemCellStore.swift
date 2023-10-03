//
//  TagItemCellStore.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation

import ComposableArchitecture

import ToolinderDomain

public struct TagItemCellStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let mode: EditMode
        public let id: UUID
        
        public let tag: Tag
        public var isSelected: Bool
        
        public init(
            mode: EditMode = .edit,
            id: UUID = .init(),
            tag: Tag,
            isSelected: Bool = false
        ) {
            self.mode = mode
            self.id = id
            self.tag = tag
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
