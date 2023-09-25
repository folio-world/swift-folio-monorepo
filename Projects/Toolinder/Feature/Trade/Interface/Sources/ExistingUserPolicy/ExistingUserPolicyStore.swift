//
//  ExistingUserPolicyStore.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 2023/09/14.
//

import Foundation

import ComposableArchitecture

public struct ExistingUserPolicyStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
