//
//  AppButton.swift
//  News
//
//  Created by Дарья Селезнёва on 10.05.2022.
//

import Foundation
import SwiftUI

struct AppButtonStyle: ButtonStyle {
    
    var foreground = Color.white
    var background = Color.blue
    
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        AppButton(foreground: foreground, background: background, configuration: configuration)
    }

    struct AppButton: View {
        
        var foreground:Color
        var background:Color
        
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .padding()
                .foregroundColor(foreground)
                .background(isEnabled ? background : Color.gray.opacity(0.3))
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .scaleEffect(configuration.isPressed ? 0.9 : 1)
        }
    }
}
