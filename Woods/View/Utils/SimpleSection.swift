//
//  SimpleSection.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct SimpleSection<Content, Header>: View where Content: View, Header: View {
    var alignment: HorizontalAlignment = .center
    @ViewBuilder var content: () -> Content
    @ViewBuilder var header: () -> Header
    
    var body: some View {
        GroupBox {
            VStack(alignment: alignment, spacing: 10) {
                content()
            }
            .padding([.top], 10)
        } label: {
            header()
        }
    }
}

extension SimpleSection where Header == EmptyView {
    init(
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(alignment: alignment, content: content) {}
    }
}

struct SimpleSection_Previews: PreviewProvider {
    static var previews: some View {
        SimpleSection {
            Text(String(repeating: "ABC ", count: 100))
        } header: {
            Label("Test", systemImage: "ellipsis")
        }
    }
}
