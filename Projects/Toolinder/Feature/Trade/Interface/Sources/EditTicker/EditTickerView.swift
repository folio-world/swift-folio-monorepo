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
                
                nameView(viewStore: viewStore)
                
                tickerTypeView(viewStore: viewStore)
                
                currencyView(viewStore: viewStore)
                
                tagView(viewStore: viewStore)
                
                Spacer()
                
                MinimalButton(title: "Save") {
                    viewStore.send(.saveButtonTapped)
                }
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
            .padding()
        }
    }
    
    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<EditTickerStore>) -> some View {
        switch viewStore.state.mode {
        case .add:
            EditHeaderView(
                mode: viewStore.state.mode,
                title: LocalizedStringKey(viewStore.state.ticker?.name ?? "Ticker"),
                isShowDismissButton: true,
                isShowDeleteButton: false
            ) { mode in
                switch mode {
                case .dismiss:
                    viewStore.send(.dismissButtonTapped)
                default: break
                }
            }
            
        case .edit:
            EditHeaderView(
                mode: viewStore.state.mode,
                title: LocalizedStringKey(viewStore.state.ticker?.name ?? "Ticker"),
                isShowDismissButton: true,
                isShowDeleteButton: true
            ) { mode in
                switch mode {
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
                    Label(viewStore.selectedTags.isEmpty ? "Tag": "", systemImage: "tag.circle.fill")
                        .foregroundStyle(.foreground)
                })
                
                ForEachStore(self.store.scope(state: \.tagItem, action: EditTickerStore.Action.tagItem(id:action:))) {
                    TagItemCellView(store: $0)
                }
            }
        }
    }
}
