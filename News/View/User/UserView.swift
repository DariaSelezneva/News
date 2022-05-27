//
//  UserView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI
import Combine

struct UserView: View {
    
    @EnvironmentObject var appState: AppState
    @AppStorage("token") var token: String = ""
    
    @StateObject var newsViewModel = NewsViewModel(newsRepository: NewsRepository(), uploadRepository: UploadPhotoRepository())
    
    @State private var editingPost: Post?
    
    var body: some View {
        ZStack {
            if token.isEmpty {
                LoginView(appState: appState)
            }
            else {
                VStack {
                    ProfileView(newsViewModel: newsViewModel,
                                userViewModel: UserViewModel(
                                    appState: appState,
                                    userRepository: UserRepository(),
                                    uploadRepository: UploadPhotoRepository()))
                    if editingPost == nil {
                        Button("Create post") {
                            if let user = appState.user {
                                let newPost = Post(id: -1, userId: user.id, title: "", text: "", image: "", username: user.name, tags: [])
                                newsViewModel.editingPost = newPost
                            }
                        }
                        .buttonStyle(AppButtonStyle())
                    }
                    if appState.user != nil {
                        NewsListView(viewModel: newsViewModel, isEditable: true)
                            .onAppear {
                                newsViewModel.getNews()
                            }
                    }
                }
            }
            
        }
        .sheet(item: $newsViewModel.editingPost) { editingPost in
            NewsEditView(viewModel: newsViewModel, post: editingPost)
        }
        .onChange(of: appState.user) { user in
            newsViewModel.selectedUser = user
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
