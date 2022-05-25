//
//  LoadableImage.swift
//  News
//
//  Created by Дарья Селезнёва on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class Cache {
    static let shared = NSCache<NSString, UIImage>()
}

struct LoadableImage: View {
    
    private enum LoadState {
        case loading, success
    }
    
    @StateObject private var loader: Loader
    
    @Binding var url: String?
    let placeholder = UIImage(named: "image-placeholder")!
    
    let onReceiveData: (UIImage) -> ()
    
    var body: some View {
        selectImage()
            .resizable()
            .onAppear {
                if let url = url {
                    loader.loadImage(url: url)
                }
            }
            .onChange(of: url) { newValue in
                if let newValue = newValue {
                    loader.loadImage(url: newValue)
                }
            }
    }
    
    init(url: Binding<String?>, onReceiveData: @escaping (UIImage) -> ()) {
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
            if let cachedImage = Cache.shared.object(forKey: NSString(string: url)) {
                self.image = cachedImage
                self.state = .success
                self.objectWillChange.send()
            }
            else {
                state = .loading
                guard let actualUrl = URL(string: url) else { return }
                URLSession.shared.dataTaskPublisher(for: actualUrl)
                    .receive(on: DispatchQueue.main)
                    .map { UIImage(data: $0.data) }
                    .replaceNil(with: UIImage(named: "image-placeholder")!)
                    .sink { _ in } receiveValue: { receivedImage in
                        self.state = .success
                        self.onReceiveData(receivedImage)
                        self.image = receivedImage
                        Cache.shared.setObject(receivedImage, forKey: NSString(string: url))
                        self.objectWillChange.send()
                    }
                    .store(in: &subscriptions)
            }
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
