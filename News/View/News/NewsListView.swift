//
//  NewsListView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject var viewModel = NewsViewModel()
    
    @State private var showsLargeCells: Bool = false
    @State private var query: String = ""
    @State private var activeTags: [String] = []
    @State private var userSelected: String?
    
    var body: some View {
        VStack {
            SearchField("Search...", text: $query)
            Picker("", selection: $showsLargeCells) {
                Image(systemName: "rectangle.grid.1x2").tag(false)
                Image(systemName: "square").tag(true)
            }
            .onChange(of: query, perform: { query in
                viewModel.query = query
                viewModel.findNews()
            })
            .pickerStyle(.segmented)
            .frame(height: 40)
            ScrollView {
                LazyVStack {
                    ForEach(Array(zip(viewModel.news.indices, viewModel.news)), id: \.0) { index, post in
                        NewsCell(post: post,
                                 activeTags: activeTags,
                                 showsLargeCells: $showsLargeCells,
                                 onTapName: {
                            
                        },
                                 onTapTag: { tag in
                            if !activeTags.contains(where: { $0 == tag.title }) {
                                activeTags.append(tag.title)
                            }
                            else {
                                activeTags = activeTags.filter({$0 != tag.title })
                            }
                            viewModel.tags = activeTags
                            viewModel.findNews()
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
        .onAppear {
            viewModel.getNews()
        }
        .padding()
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
            .environmentObject(AppState())
    }
}
