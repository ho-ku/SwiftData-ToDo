//
//  NotesRepositoryTests.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import XCTest
@testable import ToDo_SwiftData
import SwiftData

@MainActor
final class NotesRepositoryTests: XCTestCase {

    // MARK: - Tests
    
    func testAdd() {
        // GIVEN
        let newNote = Note(title: "Hello")
        let context = modelContext()
        let sut = makeSUT(modelContext: context)
        // WHEN
        sut.add(newNote)
        // THEN
        XCTAssertTrue(fetchAllNotes(in: context).contains(where: { $0.id == newNote.id }))
    }
    
    func testDelete() {
        // GIVEN
        let newNote = Note(title: "Hello World")
        let context = modelContext()
        let sut = makeSUT(modelContext: context)
        sut.add(newNote)
        // WHEN
        sut.delete(newNote)
        // THEN
        XCTAssertFalse(fetchAllNotes(in: context).contains(where: { $0.id == newNote.id }))
    }
    
    func testCounts() {
        // GIVEN
        let newCompletedNote = Note(title: "Hello World")
        newCompletedNote.isCompleted = true
        let newIncompletedNote = Note(title: "Hello")
        let context = modelContext()
        let sut = makeSUT(modelContext: context)
        // WHEN
        sut.add(newCompletedNote)
        sut.add(newIncompletedNote)
        // THEN
        XCTAssertEqual(try sut.incompletedNotesCount, 1)
        XCTAssertEqual(try sut.completedNotesCount, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(modelContext: ModelContext) -> AnyNotesRepository {
        NotesRepository(modelContext: modelContext)
    }
    
    private func modelContext() -> ModelContext {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Note.self, configurations: config)
        return container.mainContext
    }
    
    private func fetchAllNotes(in modelContext: ModelContext) -> [Note] {
        (try? modelContext.fetch(.init())) ?? []
    }

}
