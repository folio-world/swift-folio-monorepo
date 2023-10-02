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
        public var tagItem: IdentifiedArrayOf<TagItemCellStore.State> = []
        
        public var selectedTags: [Tag]
        public var name: String = ""
        public var color: Color = .blackOrWhite()
        
        public init(selectedTags: [Tag]) {
            self.selectedTags = selectedTags
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case setName(String)
        case setColor(Color)
        case dismissButtonTapped
        case confirmButtonTapped
        
        case fetchTagsRequest
        case fetchTagsResponse([Tag])
        
        case tagItem(id: TagItemCellStore.State.ID, action: TagItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case select([Tag])
        }
    }
    
    @Dependency(\.tagClient) var tagClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .fetchTagsRequest:
                let tags = (try? tagClient.fetchTags().get()) ?? []
                return .send(.fetchTagsResponse(tags))
                
            case let .fetchTagsResponse(tags):
                state.tagItem = .init(
                    uniqueElements: tags.map { tag in
                        return .init(
                            tag: tag,
                            isSelected: state.selectedTags.contains(where: { $0 == tag})
                        )
                    }
                )
                return .none
                
            case .confirmButtonTapped:
                
                return .none
                
            default:
                return .none
            }
        }
    }
}
