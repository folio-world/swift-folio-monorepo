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
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
        }
    }
}
