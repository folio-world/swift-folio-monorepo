//
//  AddTickerView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToolinderDomainTradeInterface
import ToolinderShared

public struct EditTickerView: View {
    let store: StoreOf<EditTickerStore>
    
    public init(store: StoreOf<EditTickerStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                headerView(viewStore: viewStore)
                    .padding([.top, .horizontal])
                
                if viewStore.state.mode == .add {
                    tickersView(viewStore: viewStore)
                }
                
                Divider()
                    .padding(.horizontal)
                
                nameView(viewStore: viewStore)
                    .padding(.horizontal)
                
                tickerTypeView(viewStore: viewStore)
                    .padding(.horizontal)
                
                currencyView(viewStore: viewStore)
                    .padding(.horizontal)
                
                tagView(viewStore: viewStore)
                    .padding(.horizontal)
                
                Spacer()
                
                MinimalButton(title: "Next") {
                    viewStore.send(.nextButtonTapped)
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$selectCurrency,
                    action: { .selectCurrency($0) }
                )
            ) {
                SelectCurrencyView(store: $0)
                    .presentationDetents([.medium])
            }
            .sheet(
                store: self.store.scope(
                    state: \.$selectTickerType,
                    action: { .selectTickerType($0) }
                )
            ) {
                SelectTickerTypeView(store: $0)
                    .presentationDetents([.medium])
            }
            .sheet(
                store: self.store.scope(
                    state: \.$selectTag,
                    action: { .selectTag($0) }
                )
            ) {
                SelectTagView(store: $0)
                    .presentationDetents([.medium])
            }
            .alert(
                store: self.store.scope(
                    state: \.$alert,
                    action: { .alert($0) }
                )
            )
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        HStack {
            if viewStore.state.mode == .add {
                Text("Ticker")
                    .font(.title)
            } else {
                Text(viewStore.state.selectedTicker?.name ?? "")
                    .font(.title)
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
    
    private func tickersView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEachStore(self.store.scope(state: \.tickerItem, action: EditTickerStore.Action.tickerItem(id:action:))) {
                    TickerItemCellView(store: $0)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func nameView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        TextField("Name", text: viewStore.binding(get: \.name, send: EditTickerStore.Action.setName))
            .foregroundStyle(.foreground)
    }
    
    private func tickerTypeView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        Button(action: {
            viewStore.send(.tickerTypeButtonTapped)
        }, label: {
            Label(viewStore.selectedTickerType?.rawValue ?? "Ticker Type", systemImage: viewStore.selectedTickerType?.systemImageName ?? "questionmark.circle.fill")
                .foregroundStyle(.foreground)
        })
    }
    
    private func currencyView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        Button(action: {
            viewStore.send(.currencyButtonTapped)
        }, label: {
            Label(viewStore.selectedCurrency?.rawValue ?? "Currency", systemImage: viewStore.selectedCurrency?.systemImageName ?? "questionmark.circle.fill")
                .foregroundStyle(.foreground)
        })
    }
    
    private func tagView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        ScrollView(.horizontal) {
            HStack {
                Button(action: {
                    viewStore.send(.tagButtonTapped)
                }, label: {
                    Label("Tag", systemImage: "tag.circle.fill")
                        .foregroundStyle(.foreground)
                })
                
                ForEachStore(self.store.scope(state: \.tagItem, action: EditTickerStore.Action.tagItem(id:action:))) {
                    TagItemCellView(store: $0)
                }
            }
        }
    }
}
