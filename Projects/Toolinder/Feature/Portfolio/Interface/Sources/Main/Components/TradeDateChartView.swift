//
//  TradeDateChartView.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import Foundation
import SwiftUI

import ToolinderDomain
import Charts

public struct TradeDateChartView: View {
    public let tradeDateChartDataEntity: TradeDateChartDataEntity
    
    public var body: some View {
        Chart(tradeDateChartDataEntity, id: \.self) { element in
            Plot {
                BarMark(
                    x: .value("Date", element.date, unit: .day),
                    y: .value("Sales", element.buyCount)
                )
                .foregroundStyle(by: .value("Date", element.date))
                
                BarMark(
                    x: .value("Date", element.date, unit: .day),
                    y: .value("Sales", element.sellCount)
                )
                .foregroundStyle(by: .value("Date", element.date))
            }
//            .symbol(by: .value("City", series.city))
//            .interpolationMethod(.catmullRom)
//            .position(by: .value("City", showBarsStacked ? "Common" : series.city))
        }
//        .chartXAxis {
//            AxisMarks(values: .stride(by: strideBy.time)) { _ in
//                AxisTick()
//                AxisGridLine()
//                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
//            }
//        }
//        .chartLegend((showLegend && !isOverview) ? .visible : .hidden)
//        .chartLegend(position: .top)
//        // For the simple overview chart,
//        // skip individual labels and only set the chartDescriptor
//        .accessibilityChartDescriptor(self)
//        .chartYAxis(isOverview ? .hidden : .automatic)
//        .chartXAxis(isOverview ? .hidden : .automatic)
//        .frame(height: isOverview ? Constants.previewChartHeight : Constants.detailChartHeight)
    }
}
