//
//  Date+Extension.swift
//  ToolinderSharedUtilInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
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
        
        let startOfMonth = self.startOfMonth
        var prevDates: [Date] = []
        var prevDate = calendar.date(byAdding: .day, value: -1, to: startOfMonth) ?? .now
        
        while calendar.dateComponents([.weekday], from: prevDate).weekday != 7 {
            prevDates.append(prevDate)
            guard let date = calendar.date(byAdding: .day, value: -1, to: prevDate) else { return [] }
            prevDate = date
        }
        
        let endOfMonth: Date = self.endOfMonth
        var nextDates: [Date] = []
        var nextDate: Date = calendar.date(byAdding: .day, value: 1, to: endOfMonth) ?? .now
        
        while calendar.dateComponents([.weekday], from: nextDate).weekday != 1 {
            nextDates.append(nextDate)
            guard let date = calendar.date(byAdding: .day, value: 1, to: nextDate) else { return [] }
            nextDate =  date
        }
        
        var currentDates: [Date] = []
        var currentDate: Date = startOfMonth
        
        while !currentDate.isEqual(date: endOfMonth.add(byAdding: .day, value: 1)) {
            currentDates.append(currentDate)
            guard let date = calendar.date(byAdding: .day, value: 1, to: currentDate) else { return [] }
            currentDate =  date
        }
        
        return prevDates.reversed() + currentDates + nextDates
    }
    
    func add(byAdding: Calendar.Component, value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: byAdding, value: value, to: self) ?? self
    }
    
    func isEqual(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
}
