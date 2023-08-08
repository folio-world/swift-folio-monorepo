//
//  HealthMainView.swift
//  DyingFeatureHealthInterface
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
    MonthlyHoursOfSunshine(city: "A", month: 1, hoursOfSunshine: 500),
    MonthlyHoursOfSunshine(city: "B", month: 1, hoursOfSunshine: 500),
    MonthlyHoursOfSunshine(city: "C", month: 1, hoursOfSunshine: 500),
    MonthlyHoursOfSunshine(city: "D", month: 1, hoursOfSunshine: 500),
    MonthlyHoursOfSunshine(city: "E", month: 1, hoursOfSunshine: 1000),
    MonthlyHoursOfSunshine(city: "F", month: 1, hoursOfSunshine: 1000),
]


public struct LifespanMainView: View {
    let store: StoreOf<LifespanMainStore>
    
    public init(store: StoreOf<LifespanMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                    
                    Label {
                        Text("Summary")
                            .font(.title3)
                            .fontWeight(.semibold)
                    } icon : {
                        Image(systemName: "sparkles")
                            .foregroundColor(.yellow)
                    }
                    
                    Chart(data) {
                        BarMark(
                            x: .value("Profit", $0.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("Product Category", $0.city))
                    }
                    .frame(maxHeight: 70)
                    
                    TimelineView(.periodic(from: .now, by: 0.04)) { _ in
                        Text("\(Date.now.timeIntervalSince1970)")
                            .font(.callout)
                            .padding(.bottom)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Lifespan")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
