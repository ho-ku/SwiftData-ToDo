//
//  SettingsViewModel.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 06.11.2023.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// An amount of completed notes
    var completedTasksCount: Int {
        (try? notesRepository.completedNotesCount) ?? .zero
    }
    
    /// An amount of incompleted notes
    var incompletedTasksCount: Int {
        (try? notesRepository.incompletedNotesCount) ?? .zero
    }
    
    /// A percentage of completed notes
    var completionPercent: Int {
        let totalTasks = incompletedTasksCount + completedTasksCount
        guard totalTasks != .zero else { return .zero }
        return Int(100*Double(completedTasksCount)/Double(totalTasks))
    }
    
    private let notesRepository: AnyNotesRepository
    
    // MARK: - Init
    
    init(notesRepository: AnyNotesRepository) {
        self.notesRepository = notesRepository
    }
}
