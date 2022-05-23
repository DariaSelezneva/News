//
//  LoginView.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState: appState))
    }
    
    @EnvironmentObject var appState: AppState
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showsPassword: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                VStack(spacing: 30) {
                    TextField("Email", text: $email)
                        .withBackground()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    SecureTextField(title: "Password", text: $password, showsPassword: $showsPassword)
                    Button("Login") {
                        viewModel.login(email: email, password: password)
                    }
                    .buttonStyle(AppButtonStyle())
                    .disabled(email.isEmpty || password.isEmpty)
                }
                VStack(spacing: 30) {
                    Text("Haven't registered yet?")
                    NavigationLink("Register", destination: {
                        RegisterView(appState: appState)
                    })
                }
            }
            .padding()
        }
    }
}
