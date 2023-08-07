//
//  MyPageMainView.swift
//  DyingFeatureMyPageInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI

import ComposableArchitecture

public struct MyPageMainView: View {
    let store: StoreOf<MyPageMainStore>
    
    public init(store: StoreOf<MyPageMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                
            }
            .navigationTitle("My")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
