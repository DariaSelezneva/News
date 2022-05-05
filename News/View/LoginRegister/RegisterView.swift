//
//  RegisterView.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import SwiftUI
import Photos

@available(iOS 15.0, *)
struct RegisterView: View {
    
    @State private var showsPhotoOptions: Bool = false
    
    var body: some View {
        VStack {
            Image("user-placeholder")
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            Button("Upload photo") {
                showsPhotoOptions = true
            }
        }
        .confirmationDialog("Select source", isPresented: $showsPhotoOptions) {
            Button("Take a photo") {
                // ask for camera usage permission
            }
            Button("Choose from library") {
                // ask for photos access permission
                let photosPermissionStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
                if photosPermissionStatus == .notDetermined {
                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                        if status == .authorized {
                            
                        }
                        else {
                            // show alert to settings
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 15.0, *)
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
