//
//  e_TextField.swift
//  News
//
//  Created by dunice on 05.05.2022.
//

import Foundation
import SwiftUI

struct RoundedBackground: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
            content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(colorScheme == .light ? 0.1 : 0.3)))
        }
}

extension TextField {
    
    func withBackground() -> some View {
        modifier(RoundedBackground())
    }
}
