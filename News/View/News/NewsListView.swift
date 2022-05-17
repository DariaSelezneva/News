//
//  NewsListView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct NewsListView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
    @State private var showsLargeCells: Bool = false
    @State private var query: String = ""
    @State private var activeTags: [String] = []
    
    let isEditable: Bool
    @Binding var editingPost: Post?
    
    var body: some View {
        VStack {
            SearchField("Search...", text: $query)
            Picker("", selection: $showsLargeCells) {
                Image(systemName: "rectangle.grid.1x2").tag(false)
                Image(systemName: "square").tag(true)
            }
            .onChange(of: query, perform: { query in
                viewModel.query = query
                viewModel.getNews()
            })
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
                                     activeTags: activeTags,
                                     showsLargeCells: $showsLargeCells,
                                     isEditable: isEditable,
                                     editingPost: $editingPost,
                                     onTapName: {
                                viewModel.getUser(id: post.userId)
                            },
                                     onTapTag: { tag in
                                if !activeTags.contains(where: { $0 == tag.title }) {
                                    activeTags.append(tag.title)
                                }
                                else {
                                    activeTags = activeTags.filter({$0 != tag.title })
                                }
                                viewModel.tags = activeTags
                                viewModel.getNews()
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
        .sheet(item: $viewModel.editingPost) { editingPost in
            NewsEditView(viewModel: viewModel, post: editingPost)
            
        }
    }
}
