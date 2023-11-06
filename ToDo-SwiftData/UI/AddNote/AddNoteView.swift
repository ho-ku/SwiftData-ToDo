//
//  AddNoteView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 05.11.2023.
//

import SwiftUI

struct AddNoteView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: AddNoteViewModel
    
    @Environment(\.dismiss) var dismiss
    private let previousStyle: Style
    
    // MARK: - Init
    
    init(previousStyle: Style) {
        viewModel = ServiceLocator.resolve()
        self.previousStyle = previousStyle
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("", text: $viewModel.title, prompt: Text("Note Title...").foregroundStyle(.blue.opacity(0.6)))
                .foregroundStyle(Color.appBlue)
                .font(.system(.title2, design: .rounded))
                .bold()
                .frame(height: 20)
            
            DatePicker("Select due date", selection: $viewModel.dueDate)
                .foregroundStyle(Color.appBlue)
            
            ImagePickerView(
                selectedImageData: $viewModel.imageData,
                viewData: .init(
                    title: .init(name: .chooseImage),
                    removeTitle: .init(name: .deleteImage)
                ),
                style: .blue
            )
            
            Spacer()
            
            createButton
        }
        .padding()
        .navigationTitle("Add Note")
    }
    
}

private extension AddNoteView {
    var createButton: some View {
        Button(action: {
            viewModel.create(style: previousStyle.next)
            dismiss()
        }) {
            Text("Create Note")
                .foregroundStyle(.white)
                .font(.system(.title3, design: .rounded))
                .bold()
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.appBlue)
                .cornerRadius(8)
        }
        .disabled(!viewModel.isCreationEnabled)
    }
}

#Preview {
    AddNoteView(previousStyle: .blue)
}
