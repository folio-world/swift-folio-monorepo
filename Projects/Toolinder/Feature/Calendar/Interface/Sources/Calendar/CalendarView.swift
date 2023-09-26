//
//  CalendarView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI

import ComposableArchitecture

import ToolinderFeatureTradeInterface
import ToolinderShared

public struct CalendarView: View {
    let store: StoreOf<CalendarStore>
    
    public init(store: StoreOf<CalendarStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: .zero) {
                            
                            calenderItemListView(viewStore: viewStore, proxy: proxy)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)
                            
                            tradeItemList(viewStore: viewStore)
                                .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 45)
                    }
                    
                    header(viewStore: viewStore)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$tickerEdit,
                    action: { .tickerEdit($0) }
                )
            ) {
                TickerEditView(store: $0)
                    .presentationDetents([.medium])
            }
            .sheet(
                store: self.store.scope(
                    state: \.$tradeEdit,
                    action: { .tradeEdit($0) }
                )
            ) {
                TradeEditView(store: $0)
                    .presentationDetents([.medium])
            }
            .tag(viewStore.offset)
        }
    }
    
    private func header(viewStore: ViewStoreOf<CalendarStore>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(Calendar.current.shortMonthSymbols[viewStore.state.selectedDate.month - 1])".uppercased())
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(Color(uiColor: .systemBackground).opacity(0.7))
            
            Spacer()
        }
    }
    
    private func calenderItemListView(viewStore: ViewStoreOf<CalendarStore>, proxy: GeometryProxy) -> some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
            ForEachStore(self.store.scope(state: \.calendarItem, action: CalendarStore.Action.calendarItem(id:action:))) {
                CalendarItemCellView(store: $0)
                    .frame(height: proxy.size.height * 0.12)
            }
            Spacer()
        }
    }
    
    private func tradeItemList(viewStore: ViewStoreOf<CalendarStore>) -> some View {
        VStack(alignment: .leading) {
            Text(viewStore.selectedDate.localizedString(dateStyle: .medium, timeStyle: .none))
                .font(.title3)
                .fontWeight(.bold)
            
            ForEachStore(self.store.scope(state: \.tradeItem, action: CalendarStore.Action.tradeItem(id:action:))) {
                TradeItemCellView(store: $0)
            }
            
            TradeNewItem() {
                viewStore.send(.newButtonTapped)
            }
        }
    }
}
