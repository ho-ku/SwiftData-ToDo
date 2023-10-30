//
//  Dependencies.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import Foundation
import SwiftData

final class Dependencies {
    static let live = Dependencies()
    private init() { }
}

extension Dependencies {
    func notesRepository(_ modelContext: ModelContext) -> AnyNotesRepository {
        NotesRepository(modelContext: modelContext)
    }
}
