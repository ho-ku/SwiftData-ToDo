//
//  NoteView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 01.11.2023.
//

import SwiftUI

struct NoteView: View {
    
    // MARK: - Properties
    
    @Bindable var note: Note
    var onCompletionUpdate: () -> Void
    
    @State private var isFullPresentation = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            note.style.colors.background
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) { isFullPresentation.toggle() }
                }
            
            HStack(alignment: .top) {
                Rectangle()
                    .fill(note.style.colors.foreground)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                
                VStack {
                    HStack {
                        shortInfo
                        Spacer()
                    }
                    .padding(.top)
                    
                    ImagePickerView(
                        selectedImageData: $note.imageData,
                        viewData: .init(
                            title: String(name: .chooseImage),
                            removeTitle: String(name: .deleteImage)
                        ), style: note.style
                    )
                    .isHidden(!isFullPresentation, originHeight: 140)
                    .padding(.top)
                }
                .padding(.bottom)
                
                Checkbox(isOn: note.isCompleted, color: note.style.colors.foreground)
                    .frame(width: 24)
                    .padding([.trailing, .top])
                    .onTapGesture { withAnimation { note.isCompleted.toggle() } }
                    .onChange(of: note.isCompleted) { _, _ in
                        onCompletionUpdate()
                    }
            }
        }
    }
}

private extension NoteView {
    var shortInfo: some View {
        VStack(alignment: .leading) {
            Text(DateFormatter.hourMinute.string(from: note.dueDate))
                .foregroundStyle(note.style.colors.foreground)
                .font(.system(.subheadline, design: .rounded))
                .bold()
            
            TextField("", text: $note.title)
                .foregroundStyle(note.style.colors.foreground)
                .font(.system(.headline, design: .rounded))
                .bold()
                .frame(height: 20)
        }
    }
}
