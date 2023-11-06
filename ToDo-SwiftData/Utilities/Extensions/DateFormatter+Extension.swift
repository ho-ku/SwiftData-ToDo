//
//  DateFormatter+Extension.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import Foundation

extension DateFormatter {
    
    /// A date format used to represent date's day, month and year
    /// Example: 19.12.1998
    static var dayMonthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    /// A date format used to represent date's hour and minute
    /// Example: 23:42
    static var hourMinute: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}
