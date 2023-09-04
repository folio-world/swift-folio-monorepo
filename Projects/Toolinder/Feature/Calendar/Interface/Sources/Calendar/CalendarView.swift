//
//  CalendarView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI

import ComposableArchitecture

import ToolinderShared

public struct CalendarView: View {
    let store: StoreOf<CalendarStore>
    
    public init(store: StoreOf<CalendarStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
                        ForEach(0..<30) { i in
                            CalendarCell()
                                .frame(height: proxy.size.height * 0.15)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("2023년 9월 2일 (토)")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        TradeItem()
                        
                        TradeItem()
                        
                        TradeItem()
                    }
                    .padding(.horizontal, 5)
                }
            }
        }
    }
}
