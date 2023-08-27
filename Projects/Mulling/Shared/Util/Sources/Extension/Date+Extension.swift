//
//  Date+Extension.swift
//  DyingSharedUtilInterface
//
//  Created by 송영모 on 2023/08/08.
//

import Foundation

public extension Date {
    func localizedString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.formatterBehavior = .behavior10_4
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle

        return formatter.string(from: self)
    }
}
