//
//  RegisterView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI


struct RegisterView: View {
    
    let viewModel: RegisterBusinessLogic = RegisterViewModel()
    
    @State var selectedImage: UIImage = UIImage(named: "user-placeholder")!
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var name: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            PhotoPickerView(selectedImage: $selectedImage)
            TextField("Name", text: $name)
                .withBackground()
            TextField("Email", text: $email)
                .withBackground()
            VStack {
                TextField("Password", text: $password)
                    .withBackground()
                TextField("Confirm password", text: $confirmPassword)
                    .withBackground()
            }
            Button("Register") {
                viewModel.register(avatar: selectedImage, email: email, name: name, password: password)
            }
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue))
        }
        .padding()
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
