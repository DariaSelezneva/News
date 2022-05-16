//
//  UserProfileView.swift
//  News
//
//  Created by dunice on 16.05.2022.
//

import SwiftUI

struct UserProfileView: View {
    
    let imageURL: String
    let name: String
    let email: String
    
    @Binding var selectedImage: UIImage
    
    var body: some View {
        HStack(spacing: 12) {
            LoadableImage(url: Binding(get: { imageURL }, set: { _ in }), onReceiveData: { selectedImage = $0 })
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 12) {
                Text(name)
                    .fontWeight(.semibold)
                Text(email)
            }
            Spacer()
        }
    }
}

