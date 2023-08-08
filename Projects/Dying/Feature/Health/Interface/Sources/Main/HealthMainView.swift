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


public struct HealthMainView: View {
    let store: StoreOf<HealthMainStore>
    
    public init(store: StoreOf<HealthMainStore>) {
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
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    
                    Chart(data) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                        )
                        .foregroundStyle(by: .value("City", $0.city))
                        .interpolationMethod(.catmullRom)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Health")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
