//
//  Profile.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 29.10.2023.
//

import Foundation
import SwiftData

/// Profile data object that represents current users information
@Model
final class Profile {
    
    /// Users full name
    var name: String
    
    /// Users image data
    @Attribute(.externalStorage) var imageData: Data?
    
    init(name: String, imageData: Data? = nil) {
        self.name = name
        self.imageData = imageData
    }
}
