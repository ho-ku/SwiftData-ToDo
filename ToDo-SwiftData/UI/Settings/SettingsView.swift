//
//  SettingsView.swift
//  ToDo-SwiftData
//
//  Created by Денис Андриевский on 30.10.2023.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: SettingsViewModel
    @State private var circleTrimEndValue: CGFloat = 0
    
    // MARK: - Init
    
    init() {
        viewModel = ServiceLocator.resolve()
    }
    
    var body: some View {
        VStack(spacing: 48) {
            Text("\(viewModel.completionPercent) %")
                .font(.system(size: 50))
                .foregroundStyle(Color.appBlue)
                .bold()
                .padding(64)
                .background(
                    Circle()
                        .trim(from: 0, to: circleTrimEndValue)
                        .rotation(.degrees(-90))
                        .stroke(Color.appBlue, lineWidth: 10.0)
                    
                )
                .onAppear { withAnimation { circleTrimEndValue = Double(viewModel.completionPercent)/100 } }
            
            HStack {
                Text(String(name: .open) + "\(viewModel.incompletedTasksCount)")
                    .font(.title3)
                    .foregroundStyle(Color.appBlue)
                    .bold()
                
                Spacer()
                
                Text(String(name: .completedSettings) + "\(viewModel.completedTasksCount)")
                    .font(.title3)
                    .foregroundStyle(Color.appBlue)
                    .bold()
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(String(name: .settings))
    }
}

#Preview {
    SettingsView()
        .withPreviewContext()
}
