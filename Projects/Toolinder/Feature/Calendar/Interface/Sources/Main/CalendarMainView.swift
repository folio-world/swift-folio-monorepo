//
//  CalendarMainView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI

import ComposableArchitecture

public struct CalendarMainView: View {
    let store: StoreOf<CalendarMainStore>
    
    public init(store: StoreOf<CalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView {
                    CalendarView()
                        .frame(maxHeight: .infinity)
                        .background(.yellow)
                    
                    CalendarView()
                        .frame(maxHeight: .infinity)
                        .background(.green)
                    
                    CalendarView()
                        .frame(maxHeight: .infinity)
                        .background(.red)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
