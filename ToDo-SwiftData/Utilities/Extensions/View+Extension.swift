//
//  View+Extension.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 05.11.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ value: Bool) -> some View {
        if value { self.hidden() }
        else { self }
    }
    
    @ViewBuilder
    func isHidden(_ value: Bool, originHeight: CGFloat) -> some View {
        self
            .opacity(value ? .zero : 1)
            .frame(height: value ? .zero : originHeight)
    }
}
