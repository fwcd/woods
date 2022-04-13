//
//  SimpleSection.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SimpleSection<Content>: View where Content: View {
    let header: String
    let iconName: String
    let content: () -> Content
    
    var body: some View {
        GroupBox(label: Label(header, systemImage: iconName)) {
            VStack(spacing: 10) {
                content()
            }
            .padding([.top], 10)
        }
    }
    
    init(header: String, iconName: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.iconName = iconName
        self.content = content
    }
}

struct SimpleSection_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSection(header: "Test", iconName: "ellipsis") {
            Text(String(repeating: "ABC ", count: 100))
        }
    }
}
