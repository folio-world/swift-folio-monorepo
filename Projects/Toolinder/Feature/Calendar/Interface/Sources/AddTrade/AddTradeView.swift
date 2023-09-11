//
//  AddPriceView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/08.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct AddTradeView: View {
    @Environment(\.modelContext) private var context
    let store: StoreOf<AddTradeStore>
    
    public init(store: StoreOf<AddTradeStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                headerView(viewStore: viewStore)
                
                pickerView(viewStore: viewStore)
                    .padding(.bottom)
                
                inputView(viewStore: viewStore)

                Spacer()
                
                saveButtonView(viewStore: viewStore)
            }
            .onReceive(viewStore.state.newTrade.publisher) { newTrade in
                let trade = Trade(backingData: newTrade.persistentBackingData)
                context.insert(trade)
                viewStore.send(.delegate(.save))
            }
            .padding()
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        HStack {
            Button(action: {
                viewStore.send(.dismissButtonTapped)
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundStyle(.foreground)
            })
            
            Text(viewStore.state.ticker.name ?? "")
                .font(.title)
            
            Spacer()
            
            Button(action: {
                viewStore.send(.cancleButtonTapped)
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.black)
                    .font(.title)
            })
        }
    }
    
    private func pickerView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        HStack {
            Picker("", selection: viewStore.binding(get: \.selectedTradeSide, send: AddTradeStore.Action.selectTradeSide)) {
                ForEach(TradeSide.allCases, id: \.self) { tradeSide in
                    Text(tradeSide.rawValue)
                        .tag(tradeSide)
                }
            }
            .pickerStyle(.segmented)
            
            DatePicker("", selection: viewStore.binding(get: \.selectedDate, send: AddTradeStore.Action.selectDate))
        }
    }
    
    private func inputView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "cart.circle.fill")
                
                TextField("Count", value: viewStore.binding(get: \.count, send: AddTradeStore.Action.setCount), format: .number)
                    .keyboardType(.numberPad)
                
                Spacer()
            }
            
            HStack {
                viewStore.state.ticker.currency?.image
                
                TextField("Count", value: viewStore.binding(get: \.price, send: AddTradeStore.Action.setPrice), format: .number)
                    .keyboardType(.numberPad)
                
                Spacer()
            }
        }
    }
    
    private func saveButtonView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        Button(action: {
            viewStore.send(.saveButtonTapped)
        }, label: {
            HStack {
                Spacer()
                
                Text("Save")
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
