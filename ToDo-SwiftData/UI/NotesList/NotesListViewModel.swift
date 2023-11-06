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
    private let notificationUnit: AnyNotificationUnit
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository, notificationUnit: AnyNotificationUnit) {
        self.notesRepository = notesRepository
        self.notificationUnit = notificationUnit
    }
    
    // MARK: - Methods
    
    /// Delete note
    func delete(_ note: Note) {
        notesRepository.delete(note)
    }
    
    /// Send notification with the amount of incompleted notes
    func sendNotificationIfNeeded() async {
        let incompletedNotesCount = try? notesRepository.incompletedNotesCount
        guard let incompletedNotesCount, incompletedNotesCount != .zero else { return }
        let newNotification = NotesNotification(
            id: "REMINDER",
            title: "Incompleted tasks",
            description: "You have got \(incompletedNotesCount) incompleted tasks. Let's finish them"
        )
        try? await notificationUnit.schedule(newNotification, with: .eightHour)
    }
    
    /// Request notification access
    func requestNotificationAccess() async {
        try? await notificationUnit.requestAuthorization()
    }
    
}
