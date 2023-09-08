//
//  AddTickerView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/07.
//

import SwiftUI

import ComposableArchitecture

import ToolinderShared

public struct AddTickerView: View {
    let store: StoreOf<AddTickerStore>
    
    public init(store: StoreOf<AddTickerStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
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
                
                TextField("Name", text: viewStore.$name)
                
                Spacer()
            }
            .padding()
        }
    }
}
