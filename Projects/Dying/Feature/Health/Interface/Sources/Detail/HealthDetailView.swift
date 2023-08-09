//
//  HealthDetailView.swift
//  DyingFeatureHealthDemo
//
//  Created by 송영모 on 2023/08/09.
//

import SwiftUI
import Charts

import ComposableArchitecture

public struct HealthDetailView: View {
    let store: StoreOf<HealthDetailStore>
    
    public init(store: StoreOf<HealthDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    titleView()
                    
                    Chart(data.filter({ $0.city == "Cupertino" })) {
                        BarMark(
                            x: .value("Month", $0.date),
                            y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                        )
                    }
                    .frame(maxHeight: 200)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func titleView() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                ZStack {
                    Image(systemName: "app.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                    
                    
                    Image(systemName: "drop.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading, spacing: 1) {
                Text("Water")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("3.5ml")
                    .font(.title)
                    .padding(.bottom, 2.5)
                
                Text("2023/08/09")
                    .font(.system(size: 6))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}
