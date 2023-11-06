//
//  UIApplication+Extension.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 05.11.2023.
//

import UIKit

extension UIApplication {
    
    /// End keyboard editing
    func endEditing() {
        sendAction(#selector(UIView.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
