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
            BarMark(x: .value("Date", element.date), y: .value("Count", element.buyCount))
                .foregroundStyle(by: .value("Type", "Buy"))
                .foregroundStyle(.pink)
            
            BarMark(x: .value("Date", element.date), y: .value("Count", element.sellCount))
                .foregroundStyle(by: .value("Type", "Sell"))
                .foregroundStyle(.mint)
        }
        .chartForegroundStyleScale(
            [
                "Buy": LinearGradient(gradient: Gradient(colors: [.pink]), startPoint: .top, endPoint: .bottom),
                "Sell": LinearGradient(gradient: Gradient(colors: [.mint]), startPoint: .top, endPoint: .bottom)
            ]
        )
    }
}
