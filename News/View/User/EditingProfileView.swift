//
//  EditingProfileView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct EditingProfileView: View {
    
    @AppStorage("token") var token: String = ""
    
    @Binding var image: UIImage
    @Binding var name: String
    @Binding var email: String
    
    let onCancel: () -> ()
    let onSave: () -> ()
    
    var body: some View {
        VStack(spacing: 12) {
            PhotoPickerView(selectedImage: $image)
            TextField("Name", text: $name)
                .withBackground()
            TextField("Email", text: $email)
                .withBackground()
                .autocapitalization(.none)
            HStack(spacing: 60) {
                Button("Cancel") {
                    onCancel()
                }
                Button("Save") {
                    onSave()
                }
                .buttonStyle(BlueButton())
            }
            Button("Logout") {
                token = ""
            }
            .foregroundColor(.red)
        }
    }
}

