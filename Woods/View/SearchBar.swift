//
//  SearchBar.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SearchBar: View {
    let placeholder: String
    @Binding var text: String
    var onCommit: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $text, onCommit: {
                onCommit?()
            })
        }
        .padding(8)
        .foregroundColor(.secondary)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        SearchBar(placeholder: "Test", text: $text)
    }
}
