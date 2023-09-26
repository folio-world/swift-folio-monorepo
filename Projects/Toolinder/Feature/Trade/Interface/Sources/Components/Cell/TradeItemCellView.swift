//
//  TradeItemCellView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/18.
//

import SwiftUI

import ComposableArchitecture

import ToolinderShared
import ToolinderDomain

public struct TradeItemCellView: View {
    private let store: StoreOf<TradeItemCellStore>
    
    public init(store: StoreOf<TradeItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                tradeView(viewStore: viewStore)
                
                switch viewStore.state.viewType {
                case .default:
                    EmptyView()
                case .edit:
                    editButtonView(viewStore: viewStore)
                }
            }
        }
    }
    
    private func tradeView(viewStore: ViewStoreOf<TradeItemCellStore>) -> some View {
        HStack(spacing: 10) {
            Text(
                viewStore.trade.date.localizedString(
                    dateStyle: viewStore.state.dateStyle,
                    timeStyle: viewStore.state.timeStyle
                )
            )
            .font(.headline)
            .fontWeight(.semibold)
            
            viewStore.state.trade.ticker?.type?.image
                .font(.title3)
                .foregroundStyle(viewStore.state.trade.side == .buy ? .pink : .mint)
            
            Text(viewStore.state.trade.ticker?.name ?? "")
                .font(.body)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .frame(height: 35)
        .padding(10)
        .background(viewStore.state.isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
        .onTapGesture {
            viewStore.send(.tapped)
        }
    }
    
    private func editButtonView(viewStore: ViewStoreOf<TradeItemCellStore>) -> some View {
        Button(action: {
            viewStore.send(.editButtonTapped)
        }, label: {
            Image(systemName: "square.and.pencil")
        })
        .frame(height: 35)
        .padding(10)
        .background(viewStore.state.isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
    }
}