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
    
    @StateObject private var loader: Loader
    
    let url: String
    let onReceiveData: (UIImage) -> ()
    
    var body: some View {
        Image(uiImage: loader.image)
            .resizable()
            .onAppear {
                loader.loadImage(url: url)
            }
    }
    
    init(url: String, onReceiveData: @escaping (UIImage) -> ()) {
        self.url = url
        self.onReceiveData = onReceiveData
        _loader = StateObject(wrappedValue: Loader(onReceiveData: onReceiveData))
    }
    
    private class Loader: ObservableObject {
        
        var subscriptions: Set<AnyCancellable> = []
        
        var image: UIImage = UIImage(named: "image-placeholder")!
        let onReceiveData: (UIImage) -> ()
        
        init(onReceiveData: @escaping (UIImage) -> ()) {
            self.onReceiveData = onReceiveData
        }
        
        func loadImage(url: String) {
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map { UIImage(data: $0.data) }
                .replaceNil(with: UIImage(named: "image-placeholder")!)
                .sink { _ in } receiveValue: { image in
                    self.onReceiveData(image)
                    self.image = image
                    self.objectWillChange.send()
                }
                .store(in: &subscriptions)
        }
    }
}
