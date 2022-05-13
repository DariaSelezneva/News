//
//  NewsSmallCell.swift
//  News
//
//  Created by Дарья Селезнёва on 12.05.2022.
//

import SwiftUI

struct NewsSmallCell: View {
    
    let post: Post
    let activeTags: [String]
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                LoadableImage(url: post.image, onReceiveData: { _ in })
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
                    Text(post.description)
                        .lineLimit(2)
                    
                }
                Spacer()
            }
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
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.1)))
    }
}

struct NewsSmallCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsSmallCell(post: Post.sample, activeTags: [], onTapName: {}, onTapTag: {_ in})
            .previewLayout(.sizeThatFits)
    }
}
