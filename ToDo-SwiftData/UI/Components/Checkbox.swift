//
//  Checkbox.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 31.10.2023.
//

import SwiftUI

struct Checkbox: View {
    
    var isOn: Bool
    
    var body: some View {
        if isOn {
            Image(imageName: .checkmark)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blue)
                .clipShape(Circle())
        } else {
            Circle()
                .fill(.blue.opacity(0.01))
                .stroke(.blue)
        }
    }
}

#Preview {
    Checkbox(isOn: false)
}
