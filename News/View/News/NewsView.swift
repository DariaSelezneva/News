//
//  NewsView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject var viewModel = NewsViewModel(newsRepository: NewsRepository(), uploadRepository: nil)
    
    var body: some View {
        VStack {
            if let selectedUser = viewModel.selectedUser {
                ZStack(alignment: .topTrailing) {
                    UserProfileView(imageURL: selectedUser.avatar, name: selectedUser.name, email: selectedUser.email, selectedImage: .constant(UIImage()))
                        .padding(.horizontal)
                    Button {
                        viewModel.selectedUser = nil
                        viewModel.getNews()
                    } label: {
                        Image(systemName: "multiply")
                            .font(.system(size: 24))
                            .frame(width: 50, height: 50)
                    }
                }
            }
            NewsListView(viewModel: viewModel, isEditable: false)
                .onAppear {
                    viewModel.getNews()
                }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
