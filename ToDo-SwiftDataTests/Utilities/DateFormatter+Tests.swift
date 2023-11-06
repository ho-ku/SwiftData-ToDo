//
//  DateFormatter+Tests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class DateFormatter_Tests: XCTestCase {

    func testCustomFormats() {
        let date = Date(timeIntervalSince1970: 86400*800)
        
        XCTAssertEqual(DateFormatter.dayMonthYear.string(from: date), "11.03.1972")
        XCTAssertEqual(DateFormatter.hourMinute.string(from: date), "01:00")
    }

}
