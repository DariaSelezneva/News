//
//  PhotoPickerView.swift
//  News
//
//  Created by dunice on 06.05.2022.
//

import SwiftUI
import Photos

struct PhotoPickerView: View {
    
    @Binding var selectedImage: UIImage
    var url: String?
    let isCircle: Bool
    
    @State private var photoButtonsShown: Bool = false
    @State private var showsCamera: Bool = false
    @State private var showsLibrary: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            if let url = url, !url.isEmpty {
                LoadableImage(url: Binding(get: { url }, set: { _ in }), onReceiveData: { _ in })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: isCircle ? 60 : 12))
            }
            else {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: isCircle ? 60 : 12))
            }
            Button("Select photo") {
                withAnimation(.easeInOut) {
                    photoButtonsShown.toggle()
                }
            }
            if photoButtonsShown {
                HStack(spacing: 30) {
                    Button("Camera") {
                        showsCamera = true
                    }
                    .buttonStyle(BlueButton())
                    .sheet(isPresented: $showsCamera) {
                        ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
                    }
                    Button("Library") {
                        showsLibrary = true
                    }
                    .buttonStyle(BlueButton())
                    .sheet(isPresented: $showsLibrary) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
                    }
                }
            }
        }
    }
}
