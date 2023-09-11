//
//  CalendarMainView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI
import SwiftData
import Combine

import ComposableArchitecture

import ToolinderDomainTradeInterface

public struct CalendarMainView: View {
    @Environment(\.modelContext) private var context
    
    let store: StoreOf<CalendarMainStore>
    
    public init(store: StoreOf<CalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView(selection: viewStore.binding(get: \.currentTab, send: CalendarMainStore.Action.selectTab)) {
                    ForEachStore(
                        self.store.scope(state: \.calendars, action: CalendarMainStore.Action.calendar(id:action:))
                    ) {
                        CalendarView(store: $0)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .onChange(of: viewStore.state.refreshTrigger, initial: false) {
                viewStore.send(.fetched(self.fetch()))
            }
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
                viewStore.send(.fetched(self.fetch()))
            }
        }
    }
    
    private func fetch() -> [Trade] {
        let descriptor = FetchDescriptor<Trade>(sortBy: [SortDescriptor(\Trade.date)])
        let trades = try? context.fetch(descriptor)
        
        return trades ?? []
    }
}
