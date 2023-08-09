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
                    
                    Text("Your health is 25% better than a week ago. Water levels improved by 17%, and walking improved by 38%.")
                        .font(.callout)
                        .padding(.bottom)
                    
                    Divider()
                    
                    HStack(spacing: .zero) {
                        Label {
                            Text("7 Follows")
                                .font(.title3)
                                .fontWeight(.semibold)
                        } icon : {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                    
                    VStack(spacing: 15) {
                        ForEach(0..<10) { i in
                            item()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Health")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func item() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                ZStack {
                    Image(systemName: "app.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                    
                    
                    Image(systemName: "drop.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 2)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(maxWidth: 40, maxHeight: 10)
                    
                    HStack(spacing: 1) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 5))
                            .foregroundColor(.red)
                        
                        Text("Health")
                            .font(.system(size: 6))
                            .foregroundColor(.white)
                    }
                }
            }
            VStack(spacing: 5) {
                HStack {
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Water")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        Text("3.5ml")
                            .font(.caption)
                            .padding(.bottom, 2.5)
                        
                        Text("2023/08/09")
                            .font(.system(size: 6))
                            .foregroundColor(.gray)
                    }
                    
                    Chart(data.filter({ $0.city == "Cupertino" })) {
                        LineMark(
                            x: .value("Month", $0.date),
                            y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                        )
                        .interpolationMethod(.catmullRom)
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .frame(maxHeight: 50)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    })
                }
                
                Divider()
            }
        }
    }
}
