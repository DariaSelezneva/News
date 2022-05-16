//
//  LoadableImage.swift
//  News
//
//  Created by Дарья Селезнёва on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

struct LoadableImage: View {
    
    private enum LoadState {
        case loading, success
    }
    
    @StateObject private var loader: Loader
    
    @Binding var url: String
    let placeholder = UIImage(named: "image-placeholder")!
    
    let onReceiveData: (UIImage) -> ()
    
    var body: some View {
        selectImage()
            .resizable()
            .onAppear {
                loader.loadImage(url: url)
            }
            .onChange(of: url) { newValue in
                loader.loadImage(url: newValue)
            }
    }
    
    init(url: Binding<String>, onReceiveData: @escaping (UIImage) -> ()) {
        self._url = url
        self.onReceiveData = onReceiveData
        _loader = StateObject(wrappedValue: Loader(onReceiveData: onReceiveData))
    }
    
    private class Loader: ObservableObject {
        
        var subscriptions: Set<AnyCancellable> = []
        
        var state = LoadState.loading
        
        var image: UIImage = UIImage()
        let onReceiveData: (UIImage) -> ()
        
        init(onReceiveData: @escaping (UIImage) -> ()) {
            self.onReceiveData = onReceiveData
        }
        
        func loadImage(url: String) {
            state = .loading
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map { UIImage(data: $0.data) }
                .replaceNil(with: UIImage(named: "image-placeholder")!)
                .sink { _ in } receiveValue: { image in
                    self.state = .success
                    self.onReceiveData(image)
                    self.image = image
                    self.objectWillChange.send()
                }
                .store(in: &subscriptions)
        }
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return Image(uiImage: placeholder)
        default:
            return Image(uiImage: loader.image)
        }
    }
}
