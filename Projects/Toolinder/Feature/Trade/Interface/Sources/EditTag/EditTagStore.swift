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
            
            if mode == .edit {
                self.tagName = tag?.name ?? ""
                self.tagColor = Color(hex: tag?.hex ?? "")
            }
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setTagName(String)
        case setTagColor(Color)
        case dismissButtonTapped
        case deleteButtonTapped
        case saveButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case cancle
            case save(Tag)
            case delete(Tag)
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
                
            case .dismissButtonTapped:
                return .send(.delegate(.cancle))
                
            case .deleteButtonTapped:
                if let tag = state.tag, let deletedTag = try? tagClient.deleteTag(tag).get() {
                    return .send(.delegate(.delete(deletedTag)))
                }
                return .none
                
            case .saveButtonTapped:
                guard state.tagName != "" else { return .none }
                if let tag = try? tagClient.saveTag(.init(hex: state.tagColor.toHex(), name: state.tagName)).get() {
                    return .send(.delegate(.save(tag)))
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}
