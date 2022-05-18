//
//  NewsCell.swift
//  News
//
//  Created by dunice on 13.05.2022.
//

import SwiftUI

struct NewsCell: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
    let post: Post
    @Binding var imageURL: String?
    let activeTags: [String]
    @Binding var showsLargeCells: Bool
    
    let isEditable: Bool
    @Binding var editingPost: Post?
    
    let onTapName: () -> ()
    let onTapTag: (String) -> ()
    
    @State private var showsDeletionWarning: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if showsLargeCells {
                NewsLargeCell(post: post, imageURL: $imageURL, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
            }
            else {
                NewsSmallCell(post: post, imageURL: $imageURL, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
            }
            if isEditable {
                Button {
                    viewModel.editingPost = post
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 24))
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}
