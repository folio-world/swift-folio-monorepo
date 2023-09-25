//
//  TickerTypeChartView.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation
import SwiftUI
import Charts

import ToolinderDomain

public struct TickerTypeChartView: View {
    public let tickerTypeChartDataEntity: TickerTypeChartDataEntity
    
    public var body: some View {
        HStack {
            Chart(tickerTypeChartDataEntity, id: \.self) { element in
                SectorMark(
                    angle: .value("Count", element.hold),
                    innerRadius: .ratio(0.5),
                    angularInset: 2.0
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Type", element.tickerType.rawValue))
                .annotation(position: .overlay, alignment: .center) {
                    if !element.hold.isZero {
                        Text("\(element.hold, format: .number.precision(.fractionLength(0)))")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
            }
            
            VStack {
                ForEach(tickerTypeChartDataEntity, id: \.self) { data in
                    HStack {
                        Label(data.tickerType.rawValue, systemImage: data.tickerType.systemImageName)
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
