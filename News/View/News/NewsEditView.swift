//
//  NewsEditView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct NewsEditView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel: NewsViewModel
    
    let post: Post
    
    @State var image: UIImage = UIImage(named: "image-placeholder")!
    @State var imageURL: String?
    @State var title: String = ""
    @State var text: String = ""
    
    init(viewModel: NewsViewModel, post: Post) {
        self.viewModel = viewModel
        self.post = post
        if !post.image.isEmpty {
            self._imageURL = State(wrappedValue: post.image)
        }
        self._title = State(wrappedValue: post.title)
        self._text = State(wrappedValue: post.text)
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    @State private var showsDeletionWarning: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                PhotoPickerView(selectedImage: $image, url: $imageURL, isCircle: false)
                    .aspectRatio(contentMode: .fill)
                TextField("Title", text: $title)
                    .withBackground()
                    .disableAutocorrection(true)
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(colorScheme == .light ? 0.1 : 0.3)))
                Text("Tip: use # to add hashtag in text")
                HStack(spacing: 60) {
                    Button("Cancel") {
                        viewModel.editingPost = nil
                    }
                    Button("Save") {
                        if post.id == -1 {
                            viewModel.createPost(image: image, title: title, text: text, tags: text.tags())
                        }
                        else {
                            viewModel.updatePost(id: post.id, image: image, title: title, text: text, tags: text.tags())
                        }
                    }
                    .buttonStyle(BlueButton())
                }
                Button("Delete post") {
                    showsDeletionWarning = true
                }
                .padding(.vertical)
                .foregroundColor(.red)
                .alert(isPresented: $showsDeletionWarning) {
                    Alert(title: Text("Do you want to delete this post?"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                        viewModel.deletePost(id: post.id)
                    }))
                }
            }
            .padding()
        }
    }
}
