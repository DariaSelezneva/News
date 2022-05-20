//
//  LoginView.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI

struct LoginView: View {
    
    var viewModel: LoginBusinessLogic?
    
    @EnvironmentObject var appState: AppState
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showsPassword: Bool = false
    
    @State private var showsRegistration: Bool = false
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 30) {
                TextField("Email", text: $email)
                    .withBackground()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureTextField(title: "Password", text: $password, showsPassword: $showsPassword)
                Button("Login") {
                    viewModel?.login(email: email, password: password)
                }
                .buttonStyle(AppButtonStyle()) 
                .disabled(email.isEmpty || password.isEmpty)
            }
            VStack(spacing: 30) {
                Text("Haven't registered yet?")
                Button("Register") {
                    showsRegistration = true
                }
            }
        }
        .sheet(isPresented: $showsRegistration, content: {
            RegisterView(appState: appState)
        })
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: nil)
        LoginView(viewModel: nil)
            .preferredColorScheme(.dark)
    }
}
