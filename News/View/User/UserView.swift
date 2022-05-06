//
//  UserView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI

struct UserView: View {
    
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        if token.isEmpty {
            LoginView()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
