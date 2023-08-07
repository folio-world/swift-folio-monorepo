//
//  GoalMainView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

import DyingShared

public struct GoalMainView: View {
    let store: StoreOf<GoalMainStore>
    
    public init(store: StoreOf<GoalMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVGrid(columns:  .init(repeating: .init(.adaptive(minimum: 3, maximum: 3.5), spacing: 1), count: 1), spacing: 1) {
                    ForEach(0..<viewStore.state.pointNumber, id: \.self) { i in
                        Circle()
                            .foregroundColor(i == 1000 ? .red : .gray)
                    }
                }
                .padding()
                
                HStack {
                    Spacer()
                    
                    DatePicker("", selection: viewStore.binding(get: \.currentDate, send: GoalMainStore.Action.selectDate).animation(.default), displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .frame(maxWidth: 150)
                    
                    Picker(
                      "Tab",
                      selection: viewStore.binding(get: \.currentUnit, send: GoalMainStore.Action.selectUnit).animation(.default)
                    ) {
                        ForEach(GoalMainStore.Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                                .tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 120)
                    .padding(.horizontal)
                }
                
                HStack {
                    Text(Date().localizedString(dateStyle: .short, timeStyle: .none))
                        .font(.headline)
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    
                    Text("마음 단련하기")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                    })
                }
                .padding(.horizontal)
            }
            .navigationTitle("Goal")
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
        }
    }
}
