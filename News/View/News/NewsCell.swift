//
//  NewsCell.swift
//  News
//
//  Created by dunice on 13.05.2022.
//

import SwiftUI

struct NewsCell: View {
    
    let post: Post
    @Binding var imageURL: String
    let activeTags: [String]
    @Binding var showsLargeCells: Bool
    
    let isEditable: Bool
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        ZStack {
            if showsLargeCells {
                NewsLargeCell(post: post, imageURL: $imageURL, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
            }
            else {
                NewsSmallCell(post: post, imageURL: $imageURL, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
            }
            if isEditable {
                HStack(alignment: .top) {
                    
                }
            }
        }
    }
}
