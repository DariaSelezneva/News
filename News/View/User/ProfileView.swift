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
    
    var viewModel: UserBusinessLogic?
    
    @State var isEditingUser: Bool = false
    
    @State var selectedImage: UIImage = UIImage()
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
                        }
                    }
                    else {
                        EditingProfileView(image: $selectedImage, name: $name, email: $email, onCancel: {
                            withAnimation(.easeInOut) {
                                isEditingUser = false
                            }
                        }, onSave: {
                            viewModel?.updateUser(avatar: selectedImage, name: name, email: email)
                            isEditingUser = false
                        })
                    }
                }
            }
            .onAppear {
                if appState.user == nil && token != "" {
                    viewModel?.getUser()
                }
            }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
