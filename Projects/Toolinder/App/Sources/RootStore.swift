//
//  RootStore.swift
//  DyingIOS
//
//  Created by 송영모 on 2023/08/02.
//  Copyright © 2023 folio.world. All rights reserved.
//

import ComposableArchitecture

import ToolinderFeature

struct RootStore: Reducer {
    
    enum State: Equatable {
        case mainTab(MainTabStore.State = .init())
        
        init() {
            self = .mainTab(.init())
        }
    }
    
    enum Action: Equatable {
        case mainTab(MainTabStore.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default: return .none
            }
        }
        
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
    }
}
