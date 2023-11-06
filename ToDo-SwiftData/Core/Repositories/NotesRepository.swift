//
//  NotesRepository.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import Foundation
import SwiftData

/// A repository to create or delete `Note`
protocol AnyNotesRepository {
    
    /// An amount of notes that are incompleted
    var incompletedNotesCount: Int { get throws }
    
    /// An amount of notes that are marked as completed
    var completedNotesCount: Int { get throws }
    
    /// Add `Note` to the database
    func add(_ note: Note)
    
    /// Delete `Note` from the database
    func delete(_ note: Note)
}

final class NotesRepository: AnyNotesRepository {
    
    // MARK: - Properties
    
    var incompletedNotesCount: Int {
        get throws {
            try modelContext.fetchCount(incompletedNotesDescriptor)
        }
    }
    
    var completedNotesCount: Int {
        get throws {
            try modelContext.fetchCount(completedNotesDescriptor)
        }
    }
    
    // Private properties
    private lazy var incompletedNotesDescriptor: FetchDescriptor<Note> = {
        var descriptor = FetchDescriptor<Note>()
        descriptor.predicate = #Predicate { !$0.isCompleted }
        return descriptor
    }()
    
    private lazy var completedNotesDescriptor: FetchDescriptor<Note> = {
        var descriptor = FetchDescriptor<Note>()
        descriptor.predicate = #Predicate { $0.isCompleted }
        return descriptor
    }()
    
    private let modelContext: ModelContext
    
    // MARK: - Init
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Methods
    
    func add(_ note: Note) {
        modelContext.insert(note)
    }
    
    func delete(_ note: Note) {
        modelContext.delete(note)
    }
    
}
