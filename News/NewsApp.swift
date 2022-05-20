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
    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(appState)
        }
    }
}
