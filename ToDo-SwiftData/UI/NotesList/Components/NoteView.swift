//
//  NoteView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 01.11.2023.
//

import SwiftUI

struct NoteView: View {
    
    enum Style {
        case blue
        case pink
        case yellow
        case green
        
        var colors: (foreground: Color, background: Color) {
            switch self {
            case .blue:
                return (.appBlue, .appBlueBackground)
            case .pink:
                return (.appPink, .appPinkBackground)
            case .yellow:
                return (.appYellow, .appYellowBackground)
            case .green:
                return (.appGreen, .appGreenBackground)
            }
        }
    }
    
    // MARK: - Properties
    
    @Bindable var note: Note
    let style: Style
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(style.colors.foreground)
                .frame(width: 2)
                .frame(maxHeight: .infinity)
            
            VStack {
                Text(DateFormatter.hourMinute.string(from: note.dueDate))
                    .foregroundStyle(style.colors.foreground)
                    .font(.system(.callout, design: .rounded))
                    .bold()
                
                Text(note.title)
                    .foregroundStyle(style.colors.foreground)
                    .font(.system(.callout, design: .rounded))
                    .bold()
            }
            .padding(.vertical, 12)
            
            Spacer()
            
            Checkbox(isOn: note.isCompleted, color: style.colors.foreground)
                .frame(width: 24)
                .padding(.trailing)
                .onTapGesture {
                    withAnimation { note.isCompleted.toggle() }
                }
        }
        .background(style.colors.background)
    }
}
