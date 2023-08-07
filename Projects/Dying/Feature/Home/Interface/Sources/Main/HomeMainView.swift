//
//  HomeMainView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct HomeMainView: View {
    let store: StoreOf<HomeMainStore>
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                
            }
            .navigationTitle("Home")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
