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
                if appState.user != nil {
                    if !isEditingUser {
                        HStack(spacing: 12) {
                            RemoteImage(url: user.avatar, onReceiveData: { selectedImage = $0 })
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                            VStack(alignment: .leading, spacing: 12) {
                                Text(appState.user?.name ?? "user-name")
                                Text(appState.user?.email ?? "user-email")
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
                        VStack(spacing: 12) {
                            PhotoPickerView(selectedImage: $selectedImage)
                            TextField("Name", text: $name)
                                .withBackground()
                            TextField("Email", text: $email)
                                .withBackground()
                                .autocapitalization(.none)
                            HStack(spacing: 60) {
                                Button("Cancel") {
                                    withAnimation(.easeInOut) {
                                        isEditingUser = false
                                    }
                                }
                                Button("Save") {
                                    viewModel?.updateUser(avatar: selectedImage, name: name, email: email)
                                    isEditingUser = false
                                }
                                .buttonStyle(BlueButton())
                            }
                            Spacer()
                        }
                    }
                }
            }
            .onAppear {
                if appState.user == nil && token != "" {
                    viewModel?.getUser(token: token)
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
