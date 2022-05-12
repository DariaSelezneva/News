//
//  NewsListView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct NewsListView: View {
    
    @EnvironmentObject var appState: AppState
    
    var viewModel: NewsBusinessLogic?
    
    @State private var showsLargeCells: Bool = false
    @State private var query: String = ""
    
    var body: some View {
        VStack {
            SearchField("Search author, tag or keyword", text: $query)
            HStack {
                Picker("", selection: $showsLargeCells) {
                    Image(systemName: "rectangle.grid.1x2").tag(false)
                    Image(systemName: "square").tag(true)
                }
                .pickerStyle(.segmented)
                .frame(height: 40)
            }
            ScrollView {
                LazyVStack {
                    ForEach(appState.news) { post in
                        if showsLargeCells {
                            NewsLargeCell(post: post, onTapName: {
                                
                            })
                        }
                        else {
                            NewsSmallCell(post: post, onTapName: {
                                
                            })
                        }
                    }
                }
            }
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
