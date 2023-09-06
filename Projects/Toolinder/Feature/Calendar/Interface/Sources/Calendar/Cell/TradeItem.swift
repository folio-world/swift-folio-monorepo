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
            
            RoundedRectangle(cornerRadius: 3)
                .fill(.pink)
                .frame(width: 3, height: 30)
            
            Text("삼성전자")
                .font(.body)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .padding(10)
        .background(.blue)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
    }
}
