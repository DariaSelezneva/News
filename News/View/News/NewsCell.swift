//
//  NewsCell.swift
//  News
//
//  Created by dunice on 13.05.2022.
//

import SwiftUI

struct NewsCell: View {
    
    let post: Post
    let activeTags: [String]
    @Binding var showsLargeCells: Bool
    
    let onTapName: () -> ()
    let onTapTag: (Tag) -> ()
    
    var body: some View {
        if showsLargeCells {
            NewsLargeCell(post: post, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
        }
        else {
            NewsSmallCell(post: post, activeTags: activeTags, onTapName: onTapName, onTapTag: onTapTag)
        }
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(post: Post.sample, activeTags: [], showsLargeCells: .constant(true), onTapName: {}, onTapTag: {_ in})
    }
}
