//
//  DateFormatter+Tests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class DateFormatter_Tests: XCTestCase {
    
    private var defaultDate: Date = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yyyy HH:mm"
        return formatter.date(from: "12:12:2024 15:00")!
    }()

    func testCustomFormats() {
        XCTAssertEqual(DateFormatter.dayMonthYear.string(from: defaultDate), "12.12.2024")
        XCTAssertEqual(DateFormatter.hourMinute.string(from: defaultDate), "15:00")
    }

}
