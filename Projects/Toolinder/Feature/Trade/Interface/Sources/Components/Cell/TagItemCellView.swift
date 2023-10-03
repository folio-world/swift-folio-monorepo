//
//  TagItemCellView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct TagItemCellView: View {
    private let store: StoreOf<TagItemCellStore>
    
    public init(store: StoreOf<TagItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(hex: viewStore.state.tag.hex))
                    .frame(width: 20, height: 20)
                
                Text(viewStore.state.tag.name)
                    .font(.caption2)
                    .foregroundStyle(.foreground)
                
                Spacer()
            }
            .padding(10)
            .background(viewStore.state.isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
            .onTapGesture {
                viewStore.send(.tapped)
            }
        }
    }
}
