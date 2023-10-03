//
//  EditTagView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct EditTagView: View {
    let store: StoreOf<EditTagStore>
    
    public init(store: StoreOf<EditTagStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                headerView(viewStore: viewStore)
                
                nameView(viewStore: viewStore)
                
                colorView(viewStore: viewStore)
                
                Spacer()
                
                MinimalButton(title: "Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        switch viewStore.state.mode {
        case .add:
            EditHeaderView(
                mode: viewStore.state.mode,
                title: "Tag",
                isShowDismissButton: true
            ) { action in
                switch action {
                case .dismiss:
                    viewStore.send(.dismissButtonTapped)
                default: break
                }
            }
        case .edit:
            EditHeaderView(
                mode: viewStore.state.mode,
                title: "Tag",
                isShowDeleteButton: true
            ) { action in
                switch action {
                case .dismiss:
                    viewStore.send(.dismissButtonTapped)
                case .delete:
                    viewStore.send(.deleteButtonTapped)
                default: break
                }
            }
            
        default: EmptyView()
        }
    }
    
    private func nameView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        TextField(
            text: viewStore.binding(get: \.tagName, send: EditTagStore.Action.setTagName), 
            label: {
                Label("Name", systemImage: "highlighter")
            }
        )
        .foregroundStyle(.foreground)
    }
    
    private func colorView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        ColorPicker(selection: viewStore.binding(get: \.tagColor, send: EditTagStore.Action.setTagColor), label: {
            Label("Color", systemImage: "paintpalette.fill")
        })
    }
}
