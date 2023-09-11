//
//  MyPageMainView.swift
//  ToolinderFeatureMyPageInterface
//
//  Created by 송영모 on 2023/09/11.
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
            Text("Main")
        }
    }
}
