//
//  ContentView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack() {
            NotesListView()
                .navigationTitle("Tasks")
                .toolbar {
                    NavigationLink(destination: SettingsView.init) {
                        Image(imageName: .gear)
                            .foregroundColor(.black)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
