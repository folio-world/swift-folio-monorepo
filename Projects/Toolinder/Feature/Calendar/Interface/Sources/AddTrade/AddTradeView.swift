//
//  AddPriceView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/08.
//

import SwiftUI
import SwiftData
import PhotosUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct AddTradeView: View {
    let store: StoreOf<AddTradeStore>
    
    public init(store: StoreOf<AddTradeStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 20) {
                        headerView(viewStore: viewStore)
                        
                        pickerView(viewStore: viewStore)
                            .padding(.bottom)
                        
                        inputView(viewStore: viewStore)
                        
                        Spacer()
                        
                        saveButtonView(viewStore: viewStore)
                    }
                    .frame(height: proxy.size.height)
                    .padding()
                }
            }
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        HStack {
            if viewStore.state.trade == nil {
                Button(action: {
                    viewStore.send(.dismissButtonTapped)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundStyle(.foreground)
                })
            }
            
            Text(viewStore.state.ticker.name ?? "")
                .font(.title)
            
            Spacer()
            
            if viewStore.state.trade == nil {
                Button(action: {
                    viewStore.send(.cancleButtonTapped)
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.black)
                        .font(.title)
                })
            }
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
            
            VStack(alignment: .leading) {
                Image(systemName: "note.text")
                
                TextEditor(text: viewStore.binding(get: \.note, send: AddTradeStore.Action.setNote))
            }
            
            ScrollView(.horizontal) {
                HStack {
                    Image(systemName: "photo")
                    
                    ForEach(viewStore.state.images, id: \.self) { imageData in
                        ImageItem(imageData: imageData)
                    }
                    
                    PhotosPicker(selection: viewStore.binding(get: \.selectedPhotosPickerItems, send: AddTradeStore.Action.setPhotoPickerItems),
                                 matching: .images) {
                        ImageNewItem()
                    }
                }
            }
        }
    }
    
    private func saveButtonView(viewStore: ViewStoreOf<AddTradeStore>) -> some View {
        HStack(spacing: 10) {
            if viewStore.state.trade != nil {
                Button(action: {
                    viewStore.send(.deleteButtonTapped)
                }, label: {
                    Text("Del")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(10)
                })
                .background(.black)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    )
                )
            }
            
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
}
