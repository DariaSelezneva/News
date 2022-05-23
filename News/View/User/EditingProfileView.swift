//
//  EditingProfileView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct EditingProfileView: View {
    
    @AppStorage("token") var token: String = ""
//    @EnvironmentObject var appState: AppState
    @ObservedObject var newsViewModel: NewsViewModel
    @ObservedObject var userViewModel: UserAuthViewModel
    
    @Binding var image: UIImage
    @Binding var imageURL: String?
    @Binding var name: String
    @Binding var email: String
    
    @State var showsLogoutWarning: Bool = false
    
    let onCancel: () -> ()
    let onSave: () -> ()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 12) {
                PhotoPickerView(selectedImage: $image, url: $imageURL, isCircle: true)
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
                    .buttonStyle(AppButtonStyle())
                }
            }
            Button("Logout") {
                showsLogoutWarning = true
            }
            .alert(isPresented: $showsLogoutWarning, content: {
                Alert(title: Text("Do you want to log out?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Logout"), action: {
                    token = ""
                    userViewModel.user = nil
                    newsViewModel.selectedUser = nil
                    newsViewModel.news = []
                }))
            })
            .foregroundColor(.red)
        }
    }
}

