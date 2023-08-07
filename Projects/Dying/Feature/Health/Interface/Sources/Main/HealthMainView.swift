//
//  HealthMainView.swift
//  DyingFeatureHealthInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct HealthMainView: View {
    let store: StoreOf<HealthMainStore>
    
    public init(store: StoreOf<HealthMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                
            }
            .navigationTitle("Health")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
