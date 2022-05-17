//
//  MainView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            TabView {
                NewsView()
                    .tabItem {
                        Label("News", systemImage: "line.3.horizontal")
                    }
                UserView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            if appState.loadingState == .loading {
                ProgressView()
            }
        }
        .alert(item: $appState.error) { error in
            Alert(title: Text("error"))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
