//
//  MainTabView.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import SwiftUI

import ComposableArchitecture

import ToolinderFeatureCalendarInterface
import ToolinderFeatureCalendar
import ToolinderFeaturePortfolioInterface
import ToolinderFeaturePortfolio
import ToolinderFeatureMyPageInterface
import ToolinderFeatureMyPage

public struct MainTabView: View {
    let store: StoreOf<MainTabStore>
    
    public init(store: StoreOf<MainTabStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.currentTab, send: MainTabStore.Action.selectTab)) {
                CalendarNavigationStackView(store: self.store.scope(state: \.calendar, action: MainTabStore.Action.calendar))
                    .tabItem {
                        Label(MainTabStore.Tab.calendar.rawValue, systemImage: "calendar")
                    }
                    .tag(MainTabStore.Tab.calendar)
                
                PortfolioNavigationStackView(store: self.store.scope(state: \.portfolio, action: MainTabStore.Action.portfolio))
                    .tabItem {
                        Label(MainTabStore.Tab.portfolio.rawValue, systemImage: "chart.bar.doc.horizontal")
                    }
                    .tag(MainTabStore.Tab.portfolio)
                
                MyPageNavigationStackView(store: self.store.scope(state: \.myPage, action: MainTabStore.Action.myPage))
                    .tabItem {
                        Label(MainTabStore.Tab.myPage.rawValue, systemImage: "person.crop.circle")
                    }
                    .tag(MainTabStore.Tab.myPage)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .accentColor(.black)
        }
    }
}
