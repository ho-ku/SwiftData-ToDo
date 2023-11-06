//
//  ToDo_SwiftDataApp.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import SwiftUI
import SwiftData

@main
struct ToDo_SwiftDataApp: App {
    
    private let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Note.self)
            Dependencies.registerAll(modelContext: container.mainContext)
        } catch {
            fatalError("Failed to create model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
