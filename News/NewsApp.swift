//
//  NewsApp.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI
import Combine

@main
struct NewsApp: App {
    
    let appState = AppState()
    
    @State var subs: Set<AnyCancellable> = []
    let rep = UploadPhotoRepository()
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(appState)
                .onAppear {
                    rep.uploadPhoto(UIImage(named: "cat2")!, token: nil)
                        .sink { completion in
                            print(completion)
                        } receiveValue: { url in
                            print(url)
                        }
                        .store(in: &subs)

//                    UploadPhotoRepository().uploadPhoto(UIImage(named: "cat2")!)
//                    RegisterRepository().register(avatar: catImageURL, email: "example3@bla.com", name: "NewUser", password: "12345678")
//                    LoginRepository().login(email: "example@bla.com", password: "12345678")
                }
        }
    }
}
