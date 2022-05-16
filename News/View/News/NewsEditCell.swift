//
//  NewsEditCell.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct NewsEditCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var image: UIImage = UIImage(named: "image-placeholder")!
    @State var title: String = ""
    @State var text: String = ""
    
    let onTapCancel: () -> ()
    let onTapSave: (_ image: UIImage, _ title: String, _ text: String) -> ()
    let onTapDelete: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            PhotoPickerView(selectedImage: $image)
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            TextField("Title", text: $title)
                .withBackground()
            TextEditor(text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(colorScheme == .light ? 0.1 : 0.3)))
            Text("Tip: use # to add hashtag in text")
            HStack(spacing: 60) {
                Button("Cancel") {
                    onTapCancel()
                }
                Button("Save") {
                    onTapSave(image, title, text)
                }
                .buttonStyle(BlueButton())
            }
            Button("Delete post") {
                onTapDelete()
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}
