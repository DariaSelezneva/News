//
//  NewsSmallCell.swift
//  News
//
//  Created by Дарья Селезнёва on 12.05.2022.
//

import SwiftUI

struct NewsSmallCell: View {
    
    let post: Post
    @Binding var imageURL: String
    let activeTags: [String]
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                LoadableImage(url: $imageURL, onReceiveData: { _ in })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 5) {
                    Button(post.username) {
                        onTapName()
                    }
                    Text(post.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(post.text)
                        .lineLimit(2)
                    
                }
                Spacer()
            }
            TagsView(tags: post.tags, activeTags: activeTags, onTapTag: onTapTag)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.1)))
    }
}

