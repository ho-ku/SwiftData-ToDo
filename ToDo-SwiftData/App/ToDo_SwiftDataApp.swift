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
            let config = ModelConfiguration(cloudKitDatabase: .private("iCloud.com.todoapp-swiftdata"))
            container = try ModelContainer(for: Note.self, configurations: config)
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
