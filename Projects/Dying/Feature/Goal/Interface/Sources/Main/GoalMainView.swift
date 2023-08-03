//
//  GoalMainView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

public struct GoalMainView: View {
    let store: StoreOf<GoalMainStore>
    
    public init(store: StoreOf<GoalMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            Text("goal main view")
            
            Button("title") {
                
            }
        }
        .navigationTitle("Goal")
    }
}
