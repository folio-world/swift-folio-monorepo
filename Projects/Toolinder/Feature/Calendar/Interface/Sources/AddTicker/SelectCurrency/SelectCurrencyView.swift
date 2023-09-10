//
//  SelectCurrencyView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/10.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct SelectCurrencyView: View {
    let store: StoreOf<SelectCurrencyStore>
    
    public init(store: StoreOf<SelectCurrencyStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    Text("Currency")
                        .font(.title)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 10, maximum: 500)), count: 3), alignment: .leading, spacing: 10) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Label(currency.rawValue, systemImage: currency.systemImageName)
                                .font(.body)
                                .padding(10)
                                .background(Color(uiColor: .systemGray6))
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 8,
                                        style: .continuous
                                    )
                                )
                                .onTapGesture {
                                    viewStore.send(.delegate(.select(currency)))
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
