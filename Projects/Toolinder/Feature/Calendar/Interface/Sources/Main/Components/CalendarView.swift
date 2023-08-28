//
//  CalendarView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI

import ToolinderShared

public struct CalendarView: View {
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
                ForEach(0..<30) { i in
                    Text("\(i)")
                }
            }
        }
    }
}
