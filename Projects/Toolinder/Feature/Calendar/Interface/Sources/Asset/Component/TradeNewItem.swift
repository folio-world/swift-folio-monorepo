//
//  TradeNewItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/06.
//

import SwiftUI

public struct TradeNewItem: View {
    public init() {}
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "plus")
                .font(.headline)

            Text("New")
            
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
