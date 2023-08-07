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
    @State var selectedColor = "color"
    var colors = ["year", "month", "week"]
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVGrid(columns:  .init(repeating: .init(.adaptive(minimum: 3, maximum: 3.5), spacing: 1), count: 1), spacing: 1) {
                    ForEach(0..<100, id: \.self) { i in
                        Circle()
                            .foregroundColor(i == 1000 ? .red : .gray)
                    }
                }
                .padding()
                
                HStack {
                    Spacer()
                    
                    Picker("Choose a color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 200)
                    .padding(.horizontal)
                }
                
                VStack {
                    HStack {
                        Text("goal main view")
                            .font(.title3)
                        
                        Button("plus") {
                            viewStore.send(.plus)
                        }
                        
                        Button("Minus") {
                            viewStore.send(.minus)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .onAppear {
                    viewStore.send(.onAppear, animation: .default)
                }
            }
            .navigationTitle("Goal")
        }
    }
}
