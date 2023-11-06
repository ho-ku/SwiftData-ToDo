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
    private let notificationUnit: INotificationUnit
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository, notificationUnit: INotificationUnit) {
        self.notesRepository = notesRepository
        self.notificationUnit = notificationUnit
    }
    
    // MARK: - Methods
    
    func delete(_ note: Note) {
        notesRepository.delete(note)
    }
    
    func sendNotificationIfNeeded() {
        let incompletedNotesCount = try? notesRepository.incompletedNotesCount
        guard let incompletedNotesCount, incompletedNotesCount != .zero else { return }
        let newNotification = NotesNotification(
            id: "REMINDER",
            title: "Incompleted tasks",
            description: "You have got \(incompletedNotesCount) incompleted tasks. Let's finish them"
        )
        Task {
            try? await notificationUnit.schedule(newNotification, with: .eightHour)
        }
    }
    
    func requestrNotificationAccess() async {
        try? await notificationUnit.requestAuthorization()
    }
    
}
