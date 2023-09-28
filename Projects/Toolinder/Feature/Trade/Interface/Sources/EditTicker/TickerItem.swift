//
//  TickerItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI

import ToolinderDomain

public struct TickerItem: View {
    private let ticker: Ticker
    private let isSelected: Bool
    
    private var action: () -> Void
    
    public init(
        ticker: Ticker,
        isSelected: Bool,
        action: @escaping () -> Void = {}
    ) {
        self.ticker = ticker
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Image(systemName: ticker.type.systemImageName)
                    .font(.body)
                
                Text("\(ticker.name) \(ticker.trades.count)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.trailing)
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .font(.caption)
            }
            .padding(.bottom, 10)
            
            HStack(spacing: .zero) {
                Spacer()

                Text("++76 ")
                    .font(.caption2)
                    .foregroundStyle(.pink)
                Text("--59")
                    .font(.caption2)
                    .foregroundStyle(.mint)
                Text(" 12 vol")
                    .font(.caption2)
            }
            
            HStack(spacing: .zero) {
                Spacer()
                
                Text("(avg) 12,000 \(ticker.currency.rawValue)")
                    .font(.caption2)
            }
        }
        .padding(10)
        .background(isSelected ? Color(uiColor: .systemGray5) : Color(uiColor: .systemGray6))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
        .onTapGesture {
            self.action()
        }
    }
}
