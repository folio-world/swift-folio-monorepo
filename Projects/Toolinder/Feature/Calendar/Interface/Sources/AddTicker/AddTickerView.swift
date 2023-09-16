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

public struct AddTickerView: View {
    let store: StoreOf<AddTickerStore>
    
    public init(store: StoreOf<AddTickerStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                headerView(viewStore: viewStore)
                    .padding(.top)
                    .padding(.horizontal)
                
                tickersView(viewStore: viewStore)
                
                Divider()
                    .padding(.horizontal)
                
                TextField("Name", text: viewStore.binding(get: \.name, send: AddTickerStore.Action.setName))
                    .padding(.horizontal)
                
                tickerTypeView(viewStore: viewStore)
                
                currencyView(viewStore: viewStore)
                
                Spacer()
                
                nextButtonView(viewStore: viewStore)
                    .padding()
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
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<AddTickerStore>) -> some View {
        HStack {
            Text("Ticker")
                .font(.title)
            
            Spacer()
            
            Button(action: {
                viewStore.send(.delegate(.cancel))
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.black)
                    .font(.title)
            })
        }
    }
    
    private func tickerTypeView(viewStore: ViewStoreOf<AddTickerStore>) -> some View {
        HStack {
            Label(viewStore.tickerType?.rawValue ?? "Ticker Type", systemImage: viewStore.tickerType?.systemImageName ?? "questionmark.circle.fill")
            
            Spacer()
        }
        .padding(.horizontal)
        .onTapGesture {
            viewStore.send(.tickerTypeViewTapped)
        }
    }
    
    private func currencyView(viewStore: ViewStoreOf<AddTickerStore>) -> some View {
        HStack {
            Label(viewStore.currency?.rawValue ?? "Currency", systemImage: viewStore.currency?.systemImageName ?? "questionmark.circle.fill")
            
            Spacer()
        }
        .padding(.horizontal)
        .onTapGesture {
            viewStore.send(.currencyViewTapped)
        }
    }
    
    private func tickersView(viewStore: ViewStoreOf<AddTickerStore>) -> some View {
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
    
    private func nextButtonView(viewStore: ViewStoreOf<AddTickerStore>) -> some View {
        Button(action: {
            viewStore.send(.nextButtonTapped)
        }, label: {
            HStack {
                Spacer()
                
                Text("Next")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.vertical, 10)
        })
        .background(.black)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
