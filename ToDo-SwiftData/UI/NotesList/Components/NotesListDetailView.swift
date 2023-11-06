//
//  NotesListDetailView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import SwiftUI
import SwiftData

private extension View {
    func withNeededListModifiers() -> some View {
        self
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
            .listRowBackground(Color.white)
    }
}

struct NotesListDetailView: View {
    
    // MARK: - Properties
    
    @Query var incompletedNotes: [Note]
    @Query var completedNotes: [Note]
    var onDelete: ([Note]) -> Void
    var onNoteCompletionUpdate: () -> Void
    
    // MARK: - Init
    
    init(selectedDate: Date, onDelete: @escaping ([Note]) -> Void, onNoteCompletionUpdate: @escaping () -> Void) {
        let startOfTheDay = Calendar.current.date(bySettingHour: .zero, minute: .zero, second: .zero, of: selectedDate) ?? .now
        let endOfTheDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? .now
        
        let sort = [
            SortDescriptor(\Note.dueDate, order: .forward),
            SortDescriptor(\Note.timestamp, order: .forward)
        ]
        
        _incompletedNotes = Query(filter: #Predicate<Note> {
            $0.dueDate > startOfTheDay && $0.dueDate <= endOfTheDay && !$0.isCompleted
        }, sort: sort, animation: .easeInOut)
        
        _completedNotes = Query(filter: #Predicate<Note> {
            $0.dueDate > startOfTheDay && $0.dueDate <= endOfTheDay && $0.isCompleted
        }, sort: sort, animation: .easeInOut)
        
        self.onDelete = onDelete
        self.onNoteCompletionUpdate = onNoteCompletionUpdate
    }
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(incompletedNotes, id: \.id) { note in
                NoteView(note: note, onCompletionUpdate: onNoteCompletionUpdate)
                    .withNeededListModifiers()
            }
            .onDelete(perform: deleteIncompletedSelections)
            
            if !completedNotes.isEmpty {
                Text(String(name: .completed))
                    .foregroundStyle(.blue)
                    .font(.headline)
                    .withNeededListModifiers()
            }
            
            ForEach(completedNotes, id: \.id) { note in
                NoteView(note: note, onCompletionUpdate: onNoteCompletionUpdate)
                    .withNeededListModifiers()
            }
            .onDelete(perform: deleteCompletedSelections)
        }
        .listStyle(.inset)
        .listRowSpacing(8)
        .padding(.horizontal)
        .background(.white)
        .overlay(createButton)
    }
    
    // MARK: - Private Helpers
    
    private func deleteCompletedSelections(indexsSet: IndexSet) {
        onDelete(indexsSet.map { completedNotes[$0] })
    }
    
    private func deleteIncompletedSelections(indexsSet: IndexSet) {
        onDelete(indexsSet.map { incompletedNotes[$0] })
    }
}

// MARK: - Add Note

private extension NotesListDetailView {
    var createButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    AddNoteView(previousStyle: incompletedNotes.last?.style ?? .green)
                } label: {
                    Circle()
                        .fill(Color.appBlue)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(imageName: .plus)
                                .foregroundStyle(.white)
                                .font(.system(size: 30))
                                .bold()
                        )
                }
            }
        }
        .padding(.bottom, 36)
        .padding(.trailing)
    }
}

#Preview {
    NotesListDetailView(selectedDate: .now) { _ in } onNoteCompletionUpdate: { }
        .withPreviewContext()
}
