//
//  CalendarMainView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToolinderDomain

public struct CalendarMainView: View {
    @Environment(\.modelContext) private var context
    
    let store: StoreOf<CalendarMainStore>
    
    public init(store: StoreOf<CalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView {
                    CalendarView()
                        .background(.yellow)
                    
                    CalendarView()
                        .background(.green)
                    
                    CalendarView()
                        .background(.red)
                }
                .onAppear {
                    viewStore.send(.fetched(self.fetch()))
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
    
    private func fetch() -> [Trade] {
        let descriptor = FetchDescriptor<Trade>(sortBy: [SortDescriptor(\Trade.date)])
        let trades = try? context.fetch(descriptor)
        
        return trades ?? []
    }
}
