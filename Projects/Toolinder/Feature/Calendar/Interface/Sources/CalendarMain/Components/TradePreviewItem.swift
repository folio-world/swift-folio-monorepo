//
//  TradePreviewItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ToolinderShared

public struct TradePreviewItem: View {
    public init() {}
    
    public var body: some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 3)
                .fill(.pink)
                .frame(width: 2.5, height: 11)
            
            Text("삼성전자")
                .font(.caption2)
                .fontWeight(.light)
        }
    }
}
