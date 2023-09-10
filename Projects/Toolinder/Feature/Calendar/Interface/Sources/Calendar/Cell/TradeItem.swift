//
//  TradeItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ToolinderShared

public struct TradeItem: View {
    public init() {}
    
    public var body: some View {
        HStack(spacing: 10) {
            Text("16:00")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "staroflife.circle.fill")
                .font(.title3)
                .foregroundStyle(.pink)
            
            Text("삼성전자")
                .font(.body)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .frame(height: 35)
        .padding(10)
        .background(Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
    }
}