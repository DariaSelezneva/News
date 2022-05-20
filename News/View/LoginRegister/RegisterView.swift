//
//  RegisterView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI


struct RegisterView: View {
    
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel: RegisterViewModel
    
    init(appState: AppState) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(appState: appState))
    }
    
//    @State var selectedImage: UIImage = UIImage(named: "image-placeholder")!
//    
//    @State private var name: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
    
    @State private var showsPassword: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                PhotoPickerView(selectedImage: $viewModel.selectedImage, url: .constant(nil), isCircle: true)
                TextField("Name", text: $viewModel.name)
                    .withBackground()
                TextField("Email", text: $viewModel.email)
                    .withBackground()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                VStack {
                    SecureTextField(title: "Password", text: $viewModel.password, showsPassword: $showsPassword)
                    SecureTextField(title: "Confirm password", text: $viewModel.confirmPassword, showsPassword: $showsPassword)
                }
                Button("Register") {
                    viewModel.register()
                }
//                .disabled()
                .buttonStyle(AppButtonStyle())
            }
            .padding()
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(appState: AppState())
    }
}
