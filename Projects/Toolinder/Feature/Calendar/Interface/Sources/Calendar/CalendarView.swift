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
                    VStack(spacing: .zero) {
                        HStack {
                            Text("\(Calendar.current.shortMonthSymbols[viewStore.state.selectedDate.month - 1])".uppercased())
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 5)
                        
                        calender(viewStore: viewStore, proxy: proxy)
                        
                        tradeItemList(viewStore: viewStore)
                            .padding(.horizontal, 5)
                        
                        Spacer()
                    }
                }
            }
            .tag(viewStore.offset)
        }
    }
    
    private func calender(viewStore: ViewStoreOf<CalendarStore>, proxy: GeometryProxy) -> some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
            ForEach(viewStore.state.calendars) { calendar in
                CalendarItem(
                    date: calendar.date,
                    trades: calendar.trades,
                    isSelected: calendar.date.isEqual(date: viewStore.selectedDate)
                )
                .frame(height: proxy.size.height * 0.15)
                .onTapGesture {
                    viewStore.send(.selectDate(calendar.date))
                }
            }
            
            Spacer()
        }
    }
    
    private func tradeItemList(viewStore: ViewStoreOf<CalendarStore>) -> some View {
        VStack(alignment: .leading) {
            Text(viewStore.selectedDate.localizedString(dateStyle: .medium, timeStyle: .none))
                .font(.title3)
                .fontWeight(.bold)
            
            TradeItem()
            
            TradeItem()
            
            TradeItem()
        }
    }
}
