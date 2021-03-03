//
//  SimpleSection.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct SimpleSection<Content>: View where Content: View {
    let header: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(header.uppercased())
                .foregroundColor(.secondary)
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
            content()
        }
    }
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
}

struct SimpleSection_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSection(header: "Test") {
            Text("ABC")
        }
    }
}
