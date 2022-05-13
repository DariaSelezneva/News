//
//  SecureTextField.swift
//  News
//
//  Created by Дарья Селезнёва on 10.05.2022.
//

import SwiftUI

struct SecureTextField: View {
    
    let title: String
    @Binding var text: String
    @Binding var showsPassword: Bool
    
    var body: some View {
        ZStack {
            if showsPassword {
                TextField(title, text: $text)
                    .withBackground()
                    .autocapitalization(.none)
            }
            else {
                SecureField(title, text: $text)
                    .withBackground()
                    .autocapitalization(.none)
            }
            HStack {
                Spacer()
                Button {
                    showsPassword.toggle()
                } label: {
                    Image(systemName: showsPassword ? "eye.slash" : "eye")
                }
                .frame(width: 48, height: 48)
            }
        }
    }
}

struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextField(title: "Password", text: .constant("12345678"), showsPassword: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
