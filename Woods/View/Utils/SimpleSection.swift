//
//  SimpleSection.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SimpleSection<Content>: View where Content: View {
    var header: String? = nil
    var iconName: String? = nil
    var alignment: HorizontalAlignment = .center
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GroupBox {
            VStack(alignment: alignment, spacing: 10) {
                content()
            }
            .padding([.top], 10)
        } label: {
            if let header = header {
                if let iconName = iconName {
                    Label(header, systemImage: iconName)
                } else {
                    Text(header)
                }
            } else if let iconName = iconName {
                Image(systemName: iconName)
            }
        }
    }
}

struct SimpleSection_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSection(header: "Test", iconName: "ellipsis") {
            Text(String(repeating: "ABC ", count: 100))
        }
    }
}
