//
//  StoreClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 10/9/23.
//

import Foundation
import StoreKit

import ComposableArchitecture

import ToolinderShared

public enum StoreError: Error {
    case unknown
    case failedVerification
}

public struct StoreClient {
    public var fetchProducts: () async throws -> [Product]
    public var isPurchasedRemoveAD: () async -> Bool
    
//    public init(
//        fetchProducts: @escaping () -> [Product],
//        purchase: @escaping (Product) -> Result<Product, TradeError>
//    ) {
//        self.fetchProducts = fetchProducts
//        self.purchase = purchase
//    }
}

extension StoreClient: TestDependencyKey {
    public static var previewValue: StoreClient = Self(
        fetchProducts: { return [] },
        isPurchasedRemoveAD: {return false }
    )
    
    public static var testValue = Self(
        fetchProducts: unimplemented("\(Self.self).fetchProducts"),
        isPurchasedRemoveAD: unimplemented("\(Self.self).isPurchasedRemoveAD")
    )
}

public extension DependencyValues {
    var storeClient: StoreClient {
        get { self[StoreClient.self] }
        set { self[StoreClient.self] = newValue }
    }
}

extension StoreClient: DependencyKey {
    public static var liveValue = StoreClient(
        fetchProducts: {
            let tt = try await Product.products(for: [Environment.removeAdIpaId])
            return tt
        },
        isPurchasedRemoveAD: {
            for await result in Transaction.currentEntitlements {
                do {
                    let transaction = try checkVerified(result)
                    if transaction.productID == Environment.removeAdIpaId {
                        return true
                    }
                    
                } catch {
                    print(error)
                }
            }
            return false
        }
    )
    
    private static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
}
