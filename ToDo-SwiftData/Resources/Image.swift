//
//  Image.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import SwiftUI

enum ImageName: String {
    case gear
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case checkmark = "checkmark.circle.fill"
    case plus = "plus"
}

extension Image {
    init(imageName: ImageName) {
        self = .init(systemName: imageName.rawValue)
    }
}
