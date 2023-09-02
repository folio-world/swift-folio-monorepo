//
//  CalendarCell.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ToolinderShared

public struct CalendarCell: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 2) {
            Text("2")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            TradePreviewItem()
            TradePreviewItem()
            TradePreviewItem()
        }
    }
}
