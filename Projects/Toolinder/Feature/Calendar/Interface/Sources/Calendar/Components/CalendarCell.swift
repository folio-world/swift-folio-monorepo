//
//  CalendarCell.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/02.
//

import SwiftUI

import ComposableArchitecture

import ToolinderDomain
import ToolinderShared

public struct CalendarItem: View {
    let date: Date
    let trades: [Trade]
    let isSelected: Bool
    
    public init(date: Date, trades: [Trade], isSelected: Bool) {
        self.date = date
        self.trades = trades
        self.isSelected = isSelected
    }
    
    public var body: some View {
        VStack(spacing: 2) {
            HStack {
                Spacer()
                
                Text("\(date.day)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(isSelected ? .white : .black)
                
                Spacer()
            }
            .padding(.top, 2)
            
            ForEach(trades) { trade in
                TradePreviewItem(trade: trade)
            }
            
            Spacer()
        }
        .background(isSelected ? .black : .white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
