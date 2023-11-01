//
//  NotesList.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import SwiftUI
import SwiftData

struct NotesListView: View {
    
    private struct Constants {
        static let dayInSeconds: Double = 86400
    }
    
    // MARK: - Properties
    
    @Environment(\.modelContext) var modelContext
    @ObservedObject var viewModel: NotesListViewModel
    
    // Private properties
    @State private var selectedDate: Date = .now
    
    private var dateDescription: String {
        if Calendar.current.isDateInToday(selectedDate) {
            return String(name: .today)
        } else {
            return DateFormatter.dayMonthYear.string(from: selectedDate)
        }
    }
    
    // MARK: - Init
    
    init() {
        viewModel = ServiceLocator.resolve()
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                calendarView
                    .padding()
                
                NotesListDetailView(selectedDate: selectedDate) { notesToDelete in
                    notesToDelete.forEach { viewModel.delete($0) }
                }
            }
        }
    }
}

// MARK: - Calendar

private extension NotesListView {
    var calendarView: some View {
        HStack {
            Text(dateDescription)
                .font(.headline)
                .foregroundStyle(.blue)
                .padding(.horizontal, 24)
                .padding(.vertical, 6)
                .background(
                    Color.blue
                        .opacity(0.15)
                        .cornerRadius(8)
                )
            
            Spacer()
            
            HStack {
                Button(action: { moveDate(false) }) {
                    chevronButton(.init(imageName: .chevronLeft))
                }

                Button(action: { moveDate(true) }) {
                    chevronButton(.init(imageName: .chevronRight))
                        
                }
            }
        }
    }
    
    @ViewBuilder
    func chevronButton(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 12, height: 12)
            .foregroundStyle(.gray)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.gray, lineWidth: 0.5)
                    .shadow(radius: 0.1)
            )
            
    }
    
    func moveDate(_ forward: Bool) {
        selectedDate.addTimeInterval(Constants.dayInSeconds * (forward ? 1 : -1))
    }
}

#Preview {
    NotesListView()
}
