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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVGrid(columns:  .init(repeating: .init(.adaptive(minimum: 3.5, maximum: 3.5), spacing: 1), count: 1), spacing: 1) {
                    ForEach(0..<Int(viewStore.state.cnt / 3), id: \.self) { i in
                        Circle()
                            .foregroundColor(i == 1000 ? .red : .gray)
                    }
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("goal main view")
                            .font(.title3)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Goal")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
