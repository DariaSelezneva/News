//
//  UserView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct UserView: View {
    
    @AppStorage("token") var token: String = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if token.isEmpty {
            LoginView(viewModel: LoginViewModel(appState: appState))
        }
        else {
            ProfileView(viewModel: UserViewModel(appState: appState))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
