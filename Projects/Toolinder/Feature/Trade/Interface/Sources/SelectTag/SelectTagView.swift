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
            GeometryReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        headerView(viewStore: viewStore)
                            .padding()
                        
                        tagItemListView()
                        
                        Spacer()
                        
                        MinimalButton(title: "Confirm") {
                            viewStore.send(.confirmButtonTapped)
                        }
                        .padding()
                    }
                    .frame(minHeight: proxy.size.height)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$editTag,
                    action: { .editTag($0) }
                )
            ) {
                EditTagView(store: $0)
                    .presentationDetents([.medium])
            }
        }
    }
    
    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<SelectTagStore>) -> some View {
        EditHeaderView(mode: .select, title: "Tag", isShowNewButton: true) { mode in
            switch mode {
            case .new:
                viewStore.send(.addButtonTapped)
            default: break
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
}
