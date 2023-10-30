//
//  Image.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import SwiftUI

enum ImageName: String {
    case gear
}

extension Image {
    init(imageName: ImageName) {
        self = .init(systemName: imageName.rawValue)
    }
}
