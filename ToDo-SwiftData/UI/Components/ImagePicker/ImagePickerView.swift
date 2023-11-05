//
//  ImagePickerView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 04.11.2023.
//

import SwiftUI

struct ImagePickerView: View {
    
    private struct Const {
        static let imageHeight: CGFloat = 140
        static let placeholderHeight: CGFloat = 24
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
    }
    
    public struct ViewData {
        let title: String
        let removeTitle: String
        
        public init(title: String, removeTitle: String) {
            self.title = title
            self.removeTitle = removeTitle
        }
    }
    
    // MARK: - Properties
    
    @Binding private var selectedImageData: Data?
    @State private var showActionSheet: Bool
    @State private var showImagePicker: Bool
    private let viewData: ViewData
    private let style: Style
    
    // MARK: - Init
    
    init(
        selectedImageData: Binding<Data?>,
        showActionSheet: Bool = false,
        showImagePicker: Bool = false,
        viewData: ViewData,
        style: Style
    ) {
        self._selectedImageData = selectedImageData
        self.showActionSheet = showActionSheet
        self.showImagePicker = showImagePicker
        self.viewData = viewData
        self.style = style
    }
    
    // MARK: - Body
    
    var body: some View {
        image
            .overlay(
                Color.black.opacity(0.001).onTapGesture {
                    pickImage()
                }
            )
            .sheet(isPresented: $showImagePicker) {
                ImagePickerController(selectedImageData: $selectedImageData)
                    .edgesIgnoringSafeArea(.all)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text(""),
                    buttons: [
                        .default(Text(viewData.title), action: {
                            showImagePicker.toggle()
                        }),
                        .destructive(Text(viewData.removeTitle), action: {
                            selectedImageData = nil
                        }),
                        .cancel()
                    ]
                )
            }
    }
    
    // MARK: - Helpers
    
    private var emptyState: some View {
        Text(String(name: .pickAnImage))
            .foregroundStyle(style.colors.foreground)
            .frame(height: Const.imageHeight)
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: Const.cornerRadius)
                .stroke(style.colors.foreground, lineWidth: Const.borderWidth)
                .frame(height: Const.imageHeight)
                .frame(maxWidth: .infinity))
    }
    
    @ViewBuilder
    private var image: some View {
        if let selectedImageData = selectedImageData,
           let image = UIImage(data: selectedImageData) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: Const.imageHeight)
                .frame(maxWidth: .infinity)
                .cornerRadius(Const.cornerRadius)
                .clipped()
        } else {
            emptyState
        }
    }
}

private extension ImagePickerView {
    func pickImage() {
        UIApplication.shared.endEditing()
        if selectedImageData == nil {
            showImagePicker.toggle()
        } else {
            showActionSheet.toggle()
        }
    }
}

