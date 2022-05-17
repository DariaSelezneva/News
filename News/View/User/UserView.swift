//
//  UserView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct UserView: View {
    
    @AppStorage("token") var token: String = ""
    @EnvironmentObject var appState: AppState
    @StateObject var newsViewModel = NewsViewModel()
    
    @State private var editingPost: Post?
    
    var body: some View {
        if token.isEmpty {
            LoginView(viewModel: LoginViewModel(appState: appState))
        }
        else {
            VStack {
                ProfileView(viewModel: UserViewModel(appState: appState))
                if editingPost == nil {
                    Button("Create post") {
                        if let user = appState.user {
                            let newPost = Post(id: -1, userId: user.id, title: "", text: "", image: "", username: user.name, tags: [])
                            newsViewModel.editingPost = newPost
                        }
                    }
                    .buttonStyle(BlueButton())
                }
                NewsListView(viewModel: newsViewModel, isEditable: true, editingPost: $editingPost)
            }
            .onChange(of: appState.user) { user in
                newsViewModel.selectedUser = user
                newsViewModel.getNews()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
