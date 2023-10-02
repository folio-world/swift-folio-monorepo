//
//  EditTagStore.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain

public struct EditTagStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var mode: EditMode
        public var tag: Tag?
        
        public var title: LocalizedStringKey = ""
        
        public var tagName: String = ""
        public var tagColor: Color = .blackOrWhite()
        
        public init(
            mode: EditMode,
            tag: Tag? = nil
        ) {
            self.mode = mode
            self.tag = tag
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setTagName(String)
        case setTagColor(Color)
        case dismissButtonTapped
        case deleteButtonTapped
        case confirmButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case confirm
        }
    }
    
    @Dependency(\.tagClient) var tagClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .setTagName(name):
                state.tagName = name
                return .none
                
            case let .setTagColor(color):
                state.tagColor = color
                return .none
                
            case .confirmButtonTapped:
                return .none
                
            default:
                return .none
            }
        }
    }
}
