//
//  SearchField.swift
//  News
//
//  Created by Дарья Селезнёва on 12.05.2022.
//

import SwiftUI

struct SearchField: View {
    
    let placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        ZStack {
            TextField(placeholder, text: $text)
                .withBackground()
            if !text.isEmpty {
                HStack {
                    Spacer()
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "multiply")
                            .padding()
                    }
                }
            }
            else {
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .opacity(0.5)
                }
            }
        }
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField("Placeholder", text: .constant(""))
    }
}
