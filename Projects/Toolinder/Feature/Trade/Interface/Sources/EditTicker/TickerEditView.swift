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

public struct TickerEditView: View {
    let store: StoreOf<TickerEditStore>
    
    public init(store: StoreOf<TickerEditStore>) {
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
                
                inputView(viewStore: viewStore)
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
            ) { store in
                SelectCurrencyView(store: store)
                    .presentationDetents([.medium])
            }
            .sheet(
                store: self.store.scope(
                    state: \.$selectTickerType,
                    action: { .selectTickerType($0) }
                )
            ) { store in
                SelectTickerTypeView(store: store)
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
    
    private func headerView(viewStore: ViewStoreOf<TickerEditStore>) -> some View {
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
    
    private func tickersView(viewStore: ViewStoreOf<TickerEditStore>) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewStore.state.tickers) { ticker in
                    TickerItem(
                        ticker: ticker,
                        isSelected: ticker == viewStore.selectedTicker
                    ) {
                        viewStore.send(.tickerTapped(ticker))
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func inputView(viewStore: ViewStoreOf<TickerEditStore>) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Name", text: viewStore.binding(get: \.name, send: TickerEditStore.Action.setName))
            
            Button(action: {
                viewStore.send(.tickerTypeViewTapped)
            }, label: {
                Label(viewStore.tickerType?.rawValue ?? "Ticker Type", systemImage: viewStore.tickerType?.systemImageName ?? "questionmark.circle.fill")
            })
            
            Button(action: {
                viewStore.send(.currencyViewTapped)
            }, label: {
                Label(viewStore.currency?.rawValue ?? "Currency", systemImage: viewStore.currency?.systemImageName ?? "questionmark.circle.fill")
            })
        }
        .foregroundStyle(.foreground)
    }
}
