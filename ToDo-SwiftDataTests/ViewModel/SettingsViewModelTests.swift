//
//  SettingsViewModelTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class SettingsViewModelTests: XCTestCase {
    
    func testProperties() {
        // GIVEN
        let repository = NotesRepositoryMock()
        repository.add(.init(title: "Hello"))
        repository.add(.init(title: "World", isCompleted: true))
        let sut = makeSUT(repository: repository)
        // THEN
        XCTAssertEqual(sut.completedTasksCount, 1)
        XCTAssertEqual(sut.incompletedTasksCount, 1)
        XCTAssertEqual(sut.completionPercent, 50)
    }

    // MARK: - Private Helpers
    
    private func makeSUT(repository: AnyNotesRepository) -> SettingsViewModel {
        .init(notesRepository: repository)
    }

}
