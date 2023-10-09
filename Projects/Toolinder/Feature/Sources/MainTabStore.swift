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
import ToolinderCore
import ToolinderShared

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
        
        var isPurchasedRemoveAD: Bool = false
        var interstitialed: Interstitialed = .init(id: Environment.interstitialId)
        
        public init() { }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case refresh
        
        case selectTab(Tab)
        
        case fetchIsPurchasedRemoveADReuqest
        case fetchIsPurchasedRemoveADResponse(TaskResult<Bool>)
        
        case calendar(CalendarNavigationStackStore.Action)
        case portfolio(PortfolioNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
    }
    
    @Dependency(\.storeClient) var storeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                return .send(.fetchIsPurchasedRemoveADReuqest)
                
            case .refresh:
                state = .init()
                return .none
                
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
                
            case .fetchIsPurchasedRemoveADReuqest:
                return .run { send in
                    await send(.fetchIsPurchasedRemoveADResponse(TaskResult { await storeClient.isPurchasedRemoveAD() }))
                }
                
            case let .fetchIsPurchasedRemoveADResponse(.success(isPurchased)):
                state.isPurchasedRemoveAD = isPurchased
                return .none
                
            case .portfolio(.delegate(.deleted)):
                return .send(.refresh)
                
            case .calendar(.path(.element(id: _, action: .detail(.onAppear)))), .portfolio(.path(.element(id: _, action: .tickerDetail(.onAppear)))):
                if !state.isPurchasedRemoveAD {
                    state.interstitialed.show { 
                        print("showed AD")
                    }
                }
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
