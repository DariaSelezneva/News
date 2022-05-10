//
//  BlueButton.swift
//  News
//
//  Created by Дарья Селезнёва on 10.05.2022.
//

import Foundation
import SwiftUI

struct BlueButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
