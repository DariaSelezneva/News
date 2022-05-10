//
//  LoginView.swift
//  News
//
//  Created by dunice on 04.05.2022.
//

import SwiftUI

struct LoginView: View {
    
    let viewModel = LoginViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showsPassword: Bool = false
    
    @State private var showsRegistration: Bool = false
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 30) {
                TextField("Email", text: $email)
                    .withBackground()
                    .keyboardType(.emailAddress)
                SecureTextField(title: "Password", text: $password, showsPassword: $showsPassword)
                Button("Login") {
                    viewModel.login(email: email, password: password)
                }
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue))
            }
            VStack(spacing: 30) {
                Text("Haven't registered yet?")
                Button("Register") {
                    showsRegistration = true
                }
            }
        }
        .sheet(isPresented: $showsRegistration, content: {
            if #available(iOS 15.0, *) {
                RegisterView()
            } else {
                // Fallback on earlier versions
            }
        })
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        LoginView()
            .preferredColorScheme(.dark)
    }
}
