//
//  MyPageMainStore.swift
//  ToolinderFeatureMyPageInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation

import ComposableArchitecture

public struct MyPageMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        @PresentationState var removeAD: RemoveADStore.State?
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        case delegate(Delegate)
        
        case removeADTapped
        case whatIsNewTapped
        
        case removeAD(PresentationAction<RemoveADStore.Action>)
        
        public enum Delegate: Equatable {
            case navigateToWhatIsNew
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .removeADTapped:
                state.removeAD = .init()
                return .none
                
            case .whatIsNewTapped:
                return .send(.delegate(.navigateToWhatIsNew))
                
            default:
                return .none
            }
        }
        
        .ifLet(\.$removeAD, action: /Action.removeAD) {
            RemoveADStore()
        }
    }
}
