//
//  MainView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        ZStack {
            TabView {
                NewsListView()
                    .tabItem {
                        Label("News", systemImage: "line.3.horizontal")
                    }
                UserView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
