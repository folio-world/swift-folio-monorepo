//
//  Date+Extension.swift
//  ToolinderSharedUtilInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public extension Date {
    var month: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)
        return components.month ?? 0
    }
    
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day ?? 0
    }
    
    func allDatesInMonth() -> [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        guard let startDate = calendar.date(from: components) else {
            return []
        }
        
        var currentDate = startDate
        var allDates: [Date] = []
        
        while calendar.isDate(currentDate, equalTo: startDate, toGranularity: .month) {
            allDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? Date()
        }
        
        return allDates
    }
    
    func add(byAdding: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: byAdding, value: value, to: self) ?? self
    }
}
