//
//  AddNoteViewModel.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 06.11.2023.
//

import Foundation

final class AddNoteViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// Note's title
    @Published var title: String = ""
    
    /// Note's due date
    @Published var dueDate: Date = .now
    
    /// Note's image data
    @Published var imageData: Data?
    
    /// A flag that determines if there is enough data to create a new note
    var isCreationEnabled: Bool {
        !title.isEmpty
    }
    
    private let notesRepository: AnyNotesRepository
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository) {
        self.notesRepository = notesRepository
    }
    
    // MARK: - Methods
    
    /// Create a new note
    func create(style: Style) {
        let note = Note(
            title: title,
            dueDate: dueDate,
            style: style,
            imageData: imageData
        )
        notesRepository.add(note)
    }
    
}
