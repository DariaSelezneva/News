//
//  NewsListView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
    let isEditable: Bool
    @State private var showsLargeCells: Bool = false
    
    var body: some View {
        VStack {
            SearchField("Search...", text: $viewModel.query)
            Picker("", selection: $showsLargeCells) {
                Image(systemName: "rectangle.grid.1x2").tag(false)
                Image(systemName: "square").tag(true)
            }
            .pickerStyle(.segmented)
            .frame(height: 40)
            if viewModel.news.isEmpty {
                Spacer()
                Text("Nothing here yet =(")
                Spacer()
            }
            else {
                ScrollView {
                    LazyVStack {
                        ForEach(Array(zip(viewModel.news.indices, viewModel.news)), id: \.0) { index, post in
                            NewsCell(viewModel: viewModel,
                                     post: post,
                                     imageURL: Binding(get: { post.image }, set: {_ in }),
                                     activeTags: viewModel.tags,
                                     showsLargeCells: $showsLargeCells,
                                     isEditable: isEditable,
                                     editingPost: $viewModel.editingPost,
                                     onTapName: {
                                viewModel.getUser(id: post.userId)
                            },
                                     onTapTag: { tag in
                                if !viewModel.tags.contains(where: { $0 == tag }) {
                                    viewModel.tags.append(tag)
                                }
                                else {
                                    viewModel.tags = viewModel.tags.filter({$0 != tag })
                                }
                            })
                            .onAppear {
                                if index == viewModel.news.count - 1 {
                                    viewModel.loadMore()
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        
    }
}
