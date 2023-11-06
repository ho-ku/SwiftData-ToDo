//
//  AddNoteViewModel.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 06.11.2023.
//

import Foundation

final class AddNoteViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var title: String = ""
    @Published var dueDate: Date = .now
    @Published var imageData: Data?
    
    var isCreationEnabled: Bool {
        !title.isEmpty
    }
    
    private let notesRepository: AnyNotesRepository
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository) {
        self.notesRepository = notesRepository
    }
    
    // MARK: - Methods
    
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
