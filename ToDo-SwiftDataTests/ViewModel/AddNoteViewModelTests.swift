//
//  AddNoteViewModelTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData

final class AddNoteViewModelTests: XCTestCase {
    
    func testCreate() {
        // GIVEN
        let repository = NotesRepositoryMock()
        let sut = makeSUT(notesRepository: repository)
        sut.title = "Hello"
        // WHEN
        sut.create(style: .blue)
        // THEN
        XCTAssertEqual(repository.incompletedNotesCount, 1)
    }
    
    func testIsCreationEnabled() {
        // GIVEN
        let repository = NotesRepositoryMock()
        let sut = makeSUT(notesRepository: repository)
        XCTAssertFalse(sut.isCreationEnabled)
        // WHEN
        sut.title = "Hello"
        // THEN
        XCTAssertTrue(sut.isCreationEnabled)
    }

    // MARK: - Helpers
    
    private func makeSUT(notesRepository: AnyNotesRepository) -> AddNoteViewModel {
        .init(notesRepository: notesRepository)
    }

}
