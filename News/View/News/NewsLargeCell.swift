//
//  NewsLargeCell.swift
//  News
//
//  Created by dunice on 06.05.2022.
//

import SwiftUI

struct NewsLargeCell: View {
    
    let post: Post
    @Binding var imageURL: String
    let activeTags: [String]
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            LoadableImage(url: $imageURL, onReceiveData: { _ in })
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(post.title)
                .fontWeight(.semibold)
            Text(post.text)
            HStack(spacing: 20) {
                Button(post.username) {
                    onTapName()
                }
                Spacer()
                TagsView(tags: post.tags, activeTags: activeTags, onTapTag: onTapTag)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.1)))
    }
}
