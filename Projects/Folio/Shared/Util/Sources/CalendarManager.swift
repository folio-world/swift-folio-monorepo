//
//  CalendarManager.swift
//  FolioSharedUtil
//
//  Created by 송영모 on 2023/08/28.
//

import Foundation

public struct CalendarManager {
    public static func allDatesInMonth(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
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
}
