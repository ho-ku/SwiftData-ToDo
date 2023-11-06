//
//  ImagePickerController.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 05.11.2023.
//

import SwiftUI

/// Image picker for SwiftUI
struct ImagePickerController: UIViewControllerRepresentable {
    
    // MARK: - Properties
    
    @Binding var selectedImageData: Data?
    
    @Environment(\.presentationMode) private var presentationMode
    private let sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerController>) -> some UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        private var parent: ImagePickerController
        
        init(_ parent: ImagePickerController) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.selectedImageData = image.pngData()
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

