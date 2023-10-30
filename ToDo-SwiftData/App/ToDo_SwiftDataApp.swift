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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
