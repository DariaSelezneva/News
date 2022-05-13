//
//  NewsLargeCell.swift
//  News
//
//  Created by dunice on 06.05.2022.
//

import SwiftUI

struct NewsLargeCell: View {
    
    let post: Post
    let activeTags: [String]
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            LoadableImage(url: post.image, onReceiveData: { _ in })
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(post.title)
                .fontWeight(.semibold)
            Text(post.description)
            HStack(spacing: 20) {
                Button(post.username) {
                    onTapName()
                }
                Spacer()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(post.tags) { tag in
                            Text("#" + tag.title)
                                .foregroundColor(activeTags.contains(tag.title) ? Color.white : Color.gray)
                                .opacity(0.8)
                                .onTapGesture {
                                    onTapTag(tag)
                                }
                                .padding(.all, 3)
                                .background(activeTags.contains(tag.title) ? Color.red : Color.clear)
                        }
                    }
                    .frame(height: 40)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.1)))
    }
}

struct NewsLargeCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsLargeCell(post: Post.sample, activeTags: [], onTapName: {}, onTapTag: {_ in})
            .previewLayout(.sizeThatFits)
    }
}
