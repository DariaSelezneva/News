//
//  UserView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI
import Combine

struct UserView: View {
    
    //    @EnvironmentObject var appState: AppState
    @AppStorage("token") var token: String = ""
    
    @StateObject var userViewModel = UserAuthViewModel()
    @StateObject var newsViewModel = NewsViewModel()
    
    @State private var editingPost: Post?
    
    var body: some View {
        ZStack {
            if token.isEmpty {
                LoginView(viewModel: userViewModel)
            }
            else {
                VStack {
                    ProfileView(newsViewModel: newsViewModel, userViewModel: userViewModel)
                    if editingPost == nil {
                        Button("Create post") {
                            if let user = userViewModel.user {
                                let newPost = Post(id: -1, userId: user.id, title: "", text: "", image: "", username: user.name, tags: [])
                                newsViewModel.editingPost = newPost
                            }
                        }
                        .buttonStyle(AppButtonStyle())
                    }
                    if userViewModel.user != nil {
                        NewsListView(viewModel: newsViewModel, isEditable: true)
                            .onAppear {
                                newsViewModel.getNews()
                            }
                    }
                }
            }
            
        }
        .onChange(of: userViewModel.user) { user in
            newsViewModel.selectedUser = user
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
