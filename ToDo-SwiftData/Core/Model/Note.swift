//
//  Note.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import Foundation
import SwiftData
import SwiftUI

enum Style: Codable {
    case blue
    case pink
    case green
    
    var next: Style {
        switch self {
        case .blue: return .pink
        case .pink: return .green
        case .green: return .blue
        }
    }
    
    var colors: (foreground: Color, background: Color) {
        switch self {
        case .blue: return (.appBlue, .appBlueBackground)
        case .pink: return (.appPink, .appPinkBackground)
        case .green: return (.appGreen, .appGreenBackground)
        }
    }
}

/// Note object that represents note data
@Model
final class Note {
    
    /// Notes title
    var title: String
    
    /// Notes creation timestamp
    var timestamp: Date
    
    /// Notes due date
    var dueDate: Date
    
    /// A flag that determines if note is completed
    var isCompleted: Bool
    
    /// Note style
    var style: Style
    
    /// Attached image data
    @Attribute(.externalStorage) var imageData: Data?
    
    init(
        title: String,
        timestamp: Date = .now,
        dueDate: Date = Calendar.current.startOfDay(for: .now.addingTimeInterval(86400)),
        isCompleted: Bool = false,
        style: Style = .blue,
        imageData: Data? = nil
    ) {
        self.title = title
        self.timestamp = timestamp
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.style = style
        self.imageData = imageData
    }
}
