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
        ScrollView {
            ZStack {
                if let user = appState.user {
                    if !isEditingUser {
                        HStack(spacing: 12) {
                            LoadableImage(url: Binding(get: { user.avatar }, set: { _ in }), onReceiveData: { selectedImage = $0 })
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 12) {
                                Text(user.name)
                                Text(user.email)
                            }
                            Spacer()
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
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
