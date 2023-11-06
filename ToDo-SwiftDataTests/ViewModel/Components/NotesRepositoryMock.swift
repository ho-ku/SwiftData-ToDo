//
//  NotesRepositoryMock.swift
//  ToDo-SwiftDataTests
//
//  Created by Денис Андриевский on 06.11.2023.
//

import Foundation
@testable import ToDo_SwiftData

final class NotesRepositoryMock: AnyNotesRepository {
    var incompletedNotesCount: Int {
        notes.filter { !$0.isCompleted }.count
    }
    
    var completedNotesCount: Int {
        notes.filter { $0.isCompleted }.count
    }
    
    private var notes: [Note] = []
    
    func add(_ note: Note) {
        notes.append(note)
    }
    
    func delete(_ note: Note) {
        notes.removeAll(where: { $0.id == note.id })
    }
    
}
