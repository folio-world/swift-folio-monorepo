//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import ToolinderFeatureCalendarInterface
import ToolinderFeatureCalendar
import ToolinderFeaturePortfolioInterface
import ToolinderFeaturePortfolio
import ToolinderFeatureMyPageInterface
import ToolinderFeatureMyPage


public struct MainTabStore: Reducer {
    public init() {}
    
    public enum Tab: String {
        case calendar = "Calendar"
        case portfolio = "Portfolio"
        case myPage = "MyPage"
    }
    
    public struct State: Equatable {
        var calendar: CalendarNavigationStackStore.State = .init()
        var portfolio: PortfolioNavigationStackStore.State = .init()
        var myPage: MyPageNavigationStackStore.State = .init()
        
        var currentTab: Tab = .calendar
        
        public init() { }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case selectTab(Tab)
        
        case calendar(CalendarNavigationStackStore.Action)
        case portfolio(PortfolioNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                state = .init()
                return .none
                
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.calendar, action: /Action.calendar) {
            CalendarNavigationStackStore()._printChanges()
        }
        Scope(state: \.portfolio, action: /Action.portfolio) {
            PortfolioNavigationStackStore()._printChanges()
        }
        Scope(state: \.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()._printChanges()
        }
    }
}
