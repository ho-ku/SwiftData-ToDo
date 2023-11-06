//
//  View+PreviewContext+Extension.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import SwiftUI
import SwiftData

extension View {
    @MainActor 
    func withPreviewContext() -> some View {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Note.self,
                                               configurations: config)
            let examples = [
                Note(title: "Task1", timestamp: .now, dueDate: .now.addingTimeInterval(500), isCompleted: false),
                Note(title: "Task2", timestamp: .now, dueDate: .now.addingTimeInterval(600), isCompleted: false),
                Note(title: "Task3", timestamp: .now, dueDate: .now.addingTimeInterval(700), isCompleted: true)
            ]
            for example in examples {
                container.mainContext.insert(example)
            }
            return self
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
}
