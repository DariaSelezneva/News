//
//  ProfileView.swift
//  News
//
//  Created by dunice on 11.05.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var appState: AppState
    @AppStorage("token") var token: String = ""
    @ObservedObject var newsViewModel: NewsViewModel
    
    let userViewModel: UserViewModel
    
    @State var isEditingUser: Bool = false
    
    @State var selectedImage: UIImage = UIImage()
    @State var imageURL: String?
    @State var name: String = ""
    @State var email: String = ""
    
    var body: some View {
            ZStack {
                if let user = appState.user {
                    if !isEditingUser {
                        ZStack(alignment: .topTrailing) {
                            UserProfileView(imageURL: user.avatar, name: user.name, email: user.email, selectedImage: $selectedImage)
                            Button {
                                withAnimation(.easeInOut) {
                                    isEditingUser = true
                                }
                                name = appState.user?.name ?? ""
                                email = appState.user?.email ?? ""
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.system(size: 24))
                                    .frame(width: 50, height: 50)
                            }
                            .accessibilityIdentifier("EditProfileButton")
                        }
                    }
                    else {
                        EditingProfileView(newsViewModel: newsViewModel, image: $selectedImage, imageURL: $imageURL, name: $name, email: $email, onCancel: {
                            withAnimation(.easeInOut) {
                                isEditingUser = false
                            }
                        }, onSave: {
                            userViewModel.updateUser(avatar: selectedImage, name: name, email: email)
                            isEditingUser = false
                        })
                    }
                }
            }
            .onAppear {
                if appState.user == nil && token != "" {
                    userViewModel.getUser()
                }
            }
        .padding()
    }
}
