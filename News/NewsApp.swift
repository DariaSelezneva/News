//
//  NewsApp.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI

@main
struct NewsApp: App {
    
    let version = UIDevice.current.systemVersion
    var body: some Scene {
        WindowGroup {
           LoginView()
        }
    }
}
