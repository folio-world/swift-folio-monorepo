//
//  AddTickerView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToolinderDomain
import ToolinderDomainTradeInterface
import ToolinderShared

public struct AddTickerView: View {
    @Environment(\.modelContext) private var context
    let store: StoreOf<AddTickerStore>
    
    public init(store: StoreOf<AddTickerStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                headerView(viewStore: viewStore)
                    .padding()
                
                TextField("Name", text: viewStore.binding(get: \.name, send: AddTickerStore.Action.setName))
                    .padding(.horizontal)
                
                tickerTypeView(viewStore: viewStore)
                
                currencyView(viewStore: viewStore)
                
                tickersView(viewStore: viewStore)
                
                Spacer()
                
                nextButtonView(viewStore: viewStore)
                    .padding()
            }
            .onReceive(viewStore.newTicker.publisher) {
                Ticker.init(type: .crypto, currency: .austral, name: "")
//                Trade(currency: .austral, side: .buy, price: 0, volume: 0)
//                Ticker(backingData: <#T##BackingData<Ticker>#>)
                let ticker = Ticker(backingData: $0.persistentBackingData)
                context.insert(ticker)
            }
            .onAppear {
                let descriptor = FetchDescriptor<Ticker>(sortBy: [])
                let tickers = try? context.fetch(descriptor)
                
                viewStore.send(.fetched(tickers ?? []))
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
            ForEach(viewStore.state.tickers) { ticker in
                VStack(spacing: .zero) {
                    HStack {
                        Image(systemName: ticker.type?.systemImageName ?? "")
                            .font(.body)
                        
                        Text("\(ticker.name ?? "") 4")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark.circle")
                            .font(.caption)
                    }
                    .padding(.bottom, 10)
                    
                    HStack(spacing: .zero) {
                        Spacer()

                        Text("++76 ")
                            .font(.caption2)
                            .foregroundStyle(.pink)
                        Text("--59")
                            .font(.caption2)
                            .foregroundStyle(.mint)
                        Text(" 12 cnt")
                            .font(.caption2)
                    }
                    
                    HStack(spacing: .zero) {
                        Spacer()
                        
                        Text("++76,249 ")
                            .font(.caption2)
                            .foregroundStyle(.pink)
                        Text("--76,249")
                            .font(.caption2)
                            .foregroundStyle(.mint)
                        Text(" 12 \(ticker.currency?.rawValue.lowercased() ?? "")")
                            .font(.caption2)
                    }
                }
                .padding(10)
                .background(Color(uiColor: .systemGray6))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                )
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

//FIXME: Xcode 버전 문제로 예상. 중복 코드로 해결
@Model
public class Ticker {
    public var type: TickerType? = TickerType.stock
    public var currency: Currency? = Currency.dollar
    public var name: String? = ""
    
    @Relationship(inverse: \Trade.ticker) public var trades: [Trade]? = []

    public init(
        type: TickerType,
        currency: Currency,
        name: String
    ) {
        self.type = type
        self.currency = currency
        self.name = name
    }
}
