//
//  Strings.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import Foundation

enum StringName: String {
    case today = "TODAY"
    case completed = "COMPLETED"
    case chooseImage = "Choose image"
    case deleteImage = "Delete image"
    case pickAnImage = "Pick an image"
}

extension String {
    init(name: StringName) {
        self = name.rawValue
    }
}
