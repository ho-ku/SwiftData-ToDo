//
//  NotesListViewModel.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 01.11.2023.
//

import Foundation

final class NotesListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let notesRepository: AnyNotesRepository
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository) {
        self.notesRepository = notesRepository
    }
    
    // MARK: - Methods
    
    func delete(_ note: Note) {
        notesRepository.delete(note)
    }
    
}
