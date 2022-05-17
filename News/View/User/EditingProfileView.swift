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
    
    @State var showsLogoutWarning: Bool = false
    
    let onCancel: () -> ()
    let onSave: () -> ()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 12) {
                PhotoPickerView(selectedImage: $image, isCircle: true)
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
            }
            Button("Logout") {
                showsLogoutWarning = true
            }
            .alert(isPresented: $showsLogoutWarning, content: {
                Alert(title: Text("Do you want to log out?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Logout"), action: { token = "" }))
            })
            .foregroundColor(.red)
        }
    }
}

