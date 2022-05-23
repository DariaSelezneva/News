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
    
    @ObservedObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
           MainView()
                .environmentObject(appState)
        }
    }
}
