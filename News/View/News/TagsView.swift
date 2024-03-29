//
//  TagsView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct TagsView: View {
    
    let tags: [String]
    let activeTags: [String]
    
    let onTapTag: (String) -> ()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(tags) { tag in
                    Text("#\(tag)")
                        .foregroundColor(activeTags.contains(tag) ? Color.white : Color.gray)
                        .opacity(0.8)
                        .onTapGesture {
                            onTapTag(tag)
                        }
                        .padding(.all, 3)
                        .background(RoundedRectangle(cornerRadius: 4).fill(activeTags.contains(tag) ? Color.gray : Color.clear))
                }
            }
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(tags: [], activeTags: [], onTapTag: { _ in })
    }
}
