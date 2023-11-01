//
//  Checkbox.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import SwiftUI

struct Checkbox: View {
    
    // MARK: - Properties
    
    let isOn: Bool
    let color: Color
    
    // MARK: - Body
    
    var body: some View {
        if isOn {
            Image(imageName: .checkmark)
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
                .clipShape(Circle())
        } else {
            Circle()
                .fill(.blue.opacity(0.01))
                .stroke(color)
        }
    }
}

#Preview {
    Checkbox(isOn: false, color: .blue)
}
