//
//  Note.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import Foundation
import SwiftData

/// Note object that represents note data
@Model
final class Note {
    
    /// Notes title
    var title: String
    
    /// Notes text
    var text: String
    
    /// Notes creation timestamp
    var timestamp: Date
    
    /// Notes due date
    var dueDate: Date?
    
    /// A flag that determines if note is completed
    var isCompleted: Bool
    
    /// Attached image data
    @Attribute(.externalStorage) var imageData: Data?
    
    init(
        title: String,
        text: String = "",
        timestamp: Date = .now,
        dueDate: Date? = nil,
        isCompleted: Bool = false,
        imageData: Data? = nil
    ) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.imageData = imageData
    }
}
