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
            ScrollView {
                VStack(alignment: .leading) {
                    EditHeaderView(mode: viewStore.state.mode, title: "") { action in
                        switch action {
                        case .dismiss:
                            viewStore.send(.dismissButtonTapped)
                        case .delete:
                            viewStore.send(.deleteButtonTapped)
                        default: break
                        }
                    }
                    
                    nameView(viewStore: viewStore)
                    
                    colorView(viewStore: viewStore)
                    
                    MinimalButton(title: "Confirm") {
                        viewStore.send(.confirmButtonTapped)
                    }
                }
                .padding()
            }
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        HStack {
            if viewStore.state.mode == .add {
                Button(action: {
                    viewStore.send(.dismissButtonTapped)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundStyle(.foreground)
                })
            }
            
            Spacer()
            
            if viewStore.state.mode == .edit {
                Button(action: {
                    viewStore.send(.deleteButtonTapped)
                }, label: {
                    Image(systemName: "trash.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
        }
    }
    
    private func nameView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        TextField("Name", text: viewStore.binding(get: \.tagName, send: EditTagStore.Action.setTagName))
            .foregroundStyle(.foreground)
    }
    
    private func colorView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        ColorPicker(selection: viewStore.binding(get: \.tagColor, send: EditTagStore.Action.setTagColor), label: {
            Label("Color", systemImage: "paintpalette.fill")
        })
    }
}
