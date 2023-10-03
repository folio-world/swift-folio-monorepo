//
//  SelectTagStore.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain

public struct SelectTagStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var selectedTags: [Tag]
        
        public var tagItem: IdentifiedArrayOf<TagItemCellStore.State> = []
        @PresentationState var editTag: EditTagStore.State?
        
        public init(selectedTags: [Tag]) {
            self.selectedTags = selectedTags
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case addButtonTapped
        case confirmButtonTapped
        
        case fetchTagsRequest
        case fetchTagsResponse([Tag])
        
        case tagItem(id: TagItemCellStore.State.ID, action: TagItemCellStore.Action)
        case editTag(PresentationAction<EditTagStore.Action>)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select([Tag])
            case deleted(Tag)
        }
    }
    
    @Dependency(\.tagClient) var tagClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchTagsRequest)
                ])
                
            case .addButtonTapped:
                state.editTag = .init(mode: .add)
                return .none
                
            case .confirmButtonTapped:
                return .send(.delegate(.select(state.selectedTags)))
                
            case .fetchTagsRequest:
                let tags = (try? tagClient.fetchTags().get()) ?? []
                return .send(.fetchTagsResponse(tags))
                
            case let .fetchTagsResponse(tags):
                state.tagItem = .init(
                    uniqueElements: tags.map { tag in
                        return .init(
                            mode: .edit,
                            tag: tag,
                            isSelected: state.selectedTags.contains(where: { $0 == tag })
                        )
                    }
                )
                
                return .none
                
            case let .tagItem(id: id, action: .delegate(.tapped)):
                guard let tag = state.tagItem[id: id]?.tag else { return .none }
                
                state.tagItem[id: id]?.isSelected.toggle()
                if let index = state.selectedTags.firstIndex(of: tag) {
                    state.selectedTags.remove(at: index)
                } else {
                    state.selectedTags.append(tag)
                }
                return .none
                
            case let .tagItem(id: id, action: .delegate(.editButtonTapped)):
                state.editTag = .init(mode: .edit, tag: state.tagItem[id: id]?.tag)
                return .none
                
            case .editTag(.presented(.delegate(.save))):
                state.editTag = nil
                return .send(.fetchTagsRequest)
                
            case let .editTag(.presented(.delegate(.delete(tag)))):
                if let index = state.selectedTags.firstIndex(of: tag) {
                    state.selectedTags.remove(at: index)
                }
                state.editTag = nil
                return .concatenate([
                    .send(.fetchTagsRequest),
                    .send(.delegate(.deleted(tag)))
                ])
                
            case .editTag(.dismiss):
                state.editTag = nil
                return .none
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$editTag, action: /Action.editTag) {
            EditTagStore()
        }
        
        .forEach(\.tagItem, action: /Action.tagItem(id:action:)) {
            TagItemCellStore()
        }
    }
}
