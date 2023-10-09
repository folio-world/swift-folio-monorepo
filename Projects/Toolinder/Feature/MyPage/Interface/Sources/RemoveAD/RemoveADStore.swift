//
//  PurchaseProStore.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 10/9/23.
//

import Foundation
import StoreKit

import ComposableArchitecture

import ToolinderDomain

public struct RemoveADStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var products: [Product] = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case purchased(Product)
        case fetchProductsRequest
        case fetchProductResponse(TaskResult<[Product]>)
    }
    
    private enum CancelID { case products }
    
    @Dependency(\.storeClient) var storeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchProductsRequest)
                
            case let .purchased(product):
                debugPrint(product)
                return .none
                
            case .fetchProductsRequest:
                return .run { send in
                    await send(.fetchProductResponse(TaskResult { try await self.storeClient.fetchProducts() }))
                }
                .cancellable(id: CancelID.products, cancelInFlight: true)
                
            case let .fetchProductResponse(.success(products)):
                state.products = products
                return .none
                
            default:
                return .none
            }
        }
    }
}
