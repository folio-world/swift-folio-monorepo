//
//  HomeMainView.swift
//  DyingFeatureHomeInterface
//
//  Created by 송영모 on 2023/08/07.
//

import SwiftUI
import Charts

import ComposableArchitecture

import DyingShared

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

import SwiftUI

struct TestWrappedLayout: View {
    @Binding var platforms: [String]
    
//    = ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                self.generateContent(in: geometry)
            }
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.platforms, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.platforms.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.platforms.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                ZStack {
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                    .fill(.white)
                    
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                    .stroke(.black, lineWidth: 1)
                }
            )
    }
}

public struct HomeMainView: View {
    let store: StoreOf<HomeMainStore>
    @State var platforms = ["tt"]
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {}, label: {
                        Label("", systemImage: "gearshape")
                    })
                    .foregroundColor(.black)
                }
                
                TestWrappedLayout(platforms: $platforms)
                
                HStack {
                    HStack {
                        TextField("ddd", text: .init(get: { "" }, set: { _ in }))
                    }
                    
                    Button(action: {
                        platforms.append("TMP")
                    }, label: {
                        Text("END")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                    })
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .fill(.black)
                    )
                    
                    Button(action: {
                        
                    }, label: {
                        Text("END")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(height: 45)
                            .frame(width: 100)
                    })
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .fill(.black)
                    )
                }
            }
            .padding(.horizontal)
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
