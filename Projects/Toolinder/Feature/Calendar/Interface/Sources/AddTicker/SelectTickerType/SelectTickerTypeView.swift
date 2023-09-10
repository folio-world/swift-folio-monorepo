//
//  SelectTickerTypeView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/10.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct SelectTickerTypeView: View {
    let store: StoreOf<SelectTickerTypeStore>
    
    public init(store: StoreOf<SelectTickerTypeStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                HStack {
                    Text("Ticker Type")
                        .font(.title)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: 10, maximum: 500)), count: 3), alignment: .leading, spacing: 10) {
                        ForEach(TickerType.allCases, id: \.self) { tickerType in
                            Label(tickerType.rawValue, systemImage: tickerType.systemImageName)
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
                                    viewStore.send(.delegate(.select(tickerType)))
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
