//
//  SelectTagView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct SelectTagView: View {
    let store: StoreOf<SelectTagStore>
    
    public init(store: StoreOf<SelectTagStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    EditHeaderView(mode: .select, title: "Tag") { action in
                        switch action {
                        case .dismiss:
                            viewStore.send(.dismissButtonTapped)
                        default: break
                        }
                    }
                    
                    tagItemListView()
                    
                    Divider()
                    
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
    
    private func tagItemListView() -> some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 10, maximum: 500)), count: 3), alignment: .leading, spacing: 10) {
            ForEachStore(self.store.scope(state: \.tagItem, action: SelectTagStore.Action.tagItem(id:action:))) {
                TagItemCellView(store: $0)
            }
        }
        .padding(.horizontal)
    }
    
    private func nameView(viewStore: ViewStoreOf<SelectTagStore>) -> some View {
        TextField("Name", text: viewStore.binding(get: \.name, send: SelectTagStore.Action.setName))
            .foregroundStyle(.foreground)
    }
    
    private func colorView(viewStore: ViewStoreOf<SelectTagStore>) -> some View {
        ColorPicker(selection: viewStore.binding(get: \.color, send: SelectTagStore.Action.setColor), label: {
            Label("Color", systemImage: "paintpalette.fill")
        })
    }
}
