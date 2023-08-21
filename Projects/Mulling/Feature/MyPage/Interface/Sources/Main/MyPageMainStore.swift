//
//  MyPageMainStore.swift
//  DyingFeatureMyPageInterface
//
//  Created by 송영모 on 2023/08/07.
//

import ComposableArchitecture

public struct MyPageMainStore: Reducer {
    public init() {}
    
    public struct State: Codable, Equatable, Hashable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
    }
}
