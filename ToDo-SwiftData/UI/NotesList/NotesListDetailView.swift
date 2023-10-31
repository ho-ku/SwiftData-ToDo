//
//  NotesListDetailView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import SwiftUI
import SwiftData

struct NotesListDetailView: View {
    
    // MARK: - Properties
    
    @Query var incompletedNotes: [Note]
    @Query var completedNotes: [Note]
    
    // MARK: - Init
    
    init(selectedDate: Date) {
        let startOfTheDay = Calendar.current.date(bySettingHour: .zero, minute: .zero, second: .zero, of: selectedDate) ?? .now
        let endOfTheDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? .now
        
        _incompletedNotes = Query(filter: #Predicate<Note> {
            $0.dueDate > startOfTheDay && $0.dueDate <= endOfTheDay && !$0.isCompleted
        }, sort: [SortDescriptor(\Note.dueDate, order: .forward)], animation: .easeInOut)
        
        _completedNotes = Query(filter: #Predicate<Note> {
            $0.dueDate > startOfTheDay && $0.dueDate <= endOfTheDay && $0.isCompleted
        }, sort: [SortDescriptor(\Note.dueDate, order: .forward)], animation: .easeInOut)
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(incompletedNotes, id: \.id) { note in
                    NoteView(note: note)
                }
                
                if !completedNotes.isEmpty {
                    Text(String(name: .completed))
                        .foregroundStyle(.blue)
                        .font(.headline)
                }
                
                ForEach(completedNotes, id: \.id) { note in
                    NoteView(note: note)
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Note

private extension NotesListDetailView {
    struct NoteView: View {
        
        @Bindable var note: Note
        
        var body: some View {
            HStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                
                VStack {
                    Text(DateFormatter.hourMinute.string(from: note.dueDate))
                        .foregroundStyle(.blue)
                        .font(.system(.callout, design: .rounded))
                        .bold()
                    
                    Text(note.title)
                        .foregroundStyle(.blue)
                        .font(.system(.callout, design: .rounded))
                        .bold()
                }
                .padding(.vertical, 12)
                
                Spacer()
                
                Checkbox(isOn: note.isCompleted)
                    .frame(width: 24)
                    .padding(.trailing)
                    .onTapGesture {
                        withAnimation { note.isCompleted.toggle() }
                    }
            }
            .background(
                Color.blue
                    .opacity(0.15)
            )
        }
    }
}

#Preview {
    NotesListDetailView(selectedDate: .now)
        .withPreviewContext()
}
