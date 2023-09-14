//
//  ExistingUserPolicyView.swift
//  ToolinderFeatureMyPageDemo
//
//  Created by 송영모 on 2023/09/14.
//

import SwiftUI

import ComposableArchitecture

public struct ExistingUserPolicyView: View {
    let store: StoreOf<ExistingUserPolicyStore>
    
    public init(store: StoreOf<ExistingUserPolicyStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                
            }
            .navigationTitle("Existing User Policy")
        }
    }
}
