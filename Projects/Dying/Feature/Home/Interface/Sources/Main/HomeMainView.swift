//
//  HomeMainView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI
import Charts

import ComposableArchitecture

struct MonthlyHoursOfSunshine: Identifiable {
    var id: UUID = UUID()
    var city: String
    var date: Date
    var hoursOfSunshine: Double
    
    
    init(city: String, month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.city = city
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}


var data: [MonthlyHoursOfSunshine] = [
    MonthlyHoursOfSunshine(city: "Seattle", month: 1, hoursOfSunshine: 74),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 1, hoursOfSunshine: 74),
    
    MonthlyHoursOfSunshine(city: "Seattle", month: 2, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 2, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    
    MonthlyHoursOfSunshine(city: "Seattle", month: 3, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 3, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    
    MonthlyHoursOfSunshine(city: "Seattle", month: 4, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 4, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Seattle", month: 5, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 5, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Seattle", month: 6, hoursOfSunshine: Double(Int.random(in: 0..<200))),
    MonthlyHoursOfSunshine(city: "Cupertino", month: 6, hoursOfSunshine: Double(Int.random(in: 0..<200))),
]

public struct HomeMainView: View {
    let store: StoreOf<HomeMainStore>
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    
                    lifeSpanView()
                    
                    healthView()
                    
                    goalView()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Home")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func lifeSpanView() -> some View {
        VStack(alignment: .leading) {
            Label {
                Text("Lifespan")
                    .font(.title3)
                    .fontWeight(.semibold)
            } icon : {
                Image(systemName: "sparkles")
                    .foregroundColor(.yellow)
            }
            
            Text("Analyze the time you have lived and the time left.")
                .font(.caption2)
                .foregroundColor(.gray)
            
            Chart(data) {
                BarMark(
                    x: .value("Profit", $0.hoursOfSunshine)
                )
                .foregroundStyle(by: .value("Product Category", $0.city))
            }
            .frame(height: 50)
            
            TimelineView(.periodic(from: .now, by: 0.04)) { _ in
                Text("\(Date.now.timeIntervalSince1970)")
                    .font(.callout)
                    .padding(.bottom)
            }
            
            Divider()
        }
    }
    
    private func healthView() -> some View {
        VStack(alignment: .leading) {
            Label {
                Text("Health")
                    .font(.title3)
                    .fontWeight(.semibold)
            } icon : {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
            
            Text("Analyze the health information you recorded.")
                .font(.caption2)
                .foregroundColor(.gray)
            
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
                .foregroundStyle(by: .value("City", $0.city))
                .interpolationMethod(.catmullRom)
            }
            
            Text("Your health is 25% better than a week ago. Water levels improved by 17%, and walking improved by 38%.")
                .font(.callout)
                .padding(.bottom)
            
            Divider()
        }
    }
    
    private func goalView() -> some View {
        VStack(alignment: .leading) {
            Label {
                Text("Goal")
                    .font(.title3)
                    .fontWeight(.semibold)
            } icon : {
                Image(systemName: "burst.fill")
                    .foregroundColor(.mint)
            }
            
            Text("Analyze the goals you recorded.")
                .font(.caption2)
                .foregroundColor(.gray)
            
            Chart(data) {
                PointMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
                .foregroundStyle(by: .value("City", $0.city))
                .interpolationMethod(.catmullRom)
            }
            
            Text("Your goal is 25% better than a week ago. Water levels improved by 17%, and walking improved by 38%.")
                .font(.callout)
                .padding(.bottom)
        }
    }
}
