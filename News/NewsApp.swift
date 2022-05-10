//
//  NewsApp.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI

@main
struct NewsApp: App {
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .onAppear {
//                    repository.uploadPhotoPublisher(UIImage(named: "cat2")!)
//                    RegisterRepository().register(avatar: catImageURL, email: "example3@bla.com", name: "NewUser", password: "12345678")
//                    LoginRepository().login(email: "example@bla.com", password: "12345678")
                }
        }
    }
}
