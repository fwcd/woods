//
//  PopoverNavigation.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

import SwiftUI

struct PopoverNavigation<Inner>: View where Inner: View {
    let title: String
    let onCancel: () -> Void
    @ViewBuilder let inner: () -> Inner
    
    var body: some View {
        #if os(macOS)
        inner()
            .padding(10)
        #else
        CancelNavigationStack(title: title, onCancel: onCancel) {
            inner()
        }
        #endif
    }
}
