//
//  DateFormatter+Extension.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import Foundation

extension DateFormatter {
    static var dayMonthYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    static var hourMinute: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }
}
