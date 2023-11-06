//
//  StyleTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class StyleTests: XCTestCase {
    
    func testStyles() {
        let style = Style.blue
        XCTAssertEqual(style.next, .pink)
        XCTAssertEqual(style.next.next, .green)
        XCTAssertEqual(style.next.next.next, .blue)
    }
    
}
