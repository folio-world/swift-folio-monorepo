//
//  GoalMainView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

import DyingShared

public struct PointView: View {
    let size: CGFloat
    let originX: CGFloat
    let originY: CGFloat
    
    
    public init(size: CGFloat, x: CGFloat, y: CGFloat) {
        self.size = size
        self.originX = x
        self.originY = y
    }
    
    public var body: some View {
        Circle()
            .frame(width: size, height: size)
            .offset(x: originX, y: originY)
    }
}

public struct PointGraphView: View {
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let size: CGFloat
    let number: Int
    
    private var fullWidth: CGFloat {
        return UIScreen.screenWidth - horizontalPadding
    }
    
    private var fullHeight: CGFloat {
        return CGFloat(Int(number / lineLimit)) * (size + spacing)
    }
    
    private var lineLimit: Int {
        return Int(fullWidth / (size + spacing))
    }
    
    public var body: some View {
        ZStack {
            ForEach(offsets(), id: \.0) {
                PointView(size: size, x: $1, y: $2)
            }
        }
        .padding(.bottom, fullHeight)
    }
    
    private func offsets() -> [(UUID, Double, Double)] {
        let lineLimit = self.lineLimit
        let baseOffsetWidth = self.fullWidth / 2
        let baseOffsetHeight = 0.0
        
        var result: [(UUID, Double, Double)] = []
        
        for i in 0..<number {
            let x = CGFloat(i % lineLimit) * (size + spacing) - baseOffsetWidth
            let y = CGFloat(i / lineLimit) * (size + spacing) - baseOffsetHeight
            result.append((UUID(), x, y))
        }
        
        return result
    }
}

public struct GoalMainView: View {
    let store: StoreOf<GoalMainStore>
    
    public init(store: StoreOf<GoalMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                PointGraphView(spacing: 1, horizontalPadding: 20, size: 3, number: viewStore.state.pointNumber)
                
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
                    .frame(maxWidth: 200)
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
                            .foregroundColor(.black)
                    })
                }
                .padding()
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black, lineWidth: 1)
                )
                .padding(.horizontal)
            }
            .navigationTitle("Goal")
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
        }
    }
}
