//
//  SelectTagView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct SelectTagView: View {
    let store: StoreOf<SelectCurrencyStore>
    
    public init(store: StoreOf<SelectCurrencyStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    Text("Currency")
                        .font(.title)
                    Spacer()
                }
                .padding()
                
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
