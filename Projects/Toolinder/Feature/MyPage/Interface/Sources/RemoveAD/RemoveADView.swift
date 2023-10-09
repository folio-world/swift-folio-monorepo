//
//  PurchaseProView.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 10/9/23.
//

import Foundation
import SwiftUI
import StoreKit

import ComposableArchitecture

import ToolinderShared

public struct RemoveADView: View {
    let store: StoreOf<RemoveADStore>
    
    public init(store: StoreOf<RemoveADStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            StoreView(products: viewStore.state.products)
                .storeButton(.visible, for: .restorePurchases)
                
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
