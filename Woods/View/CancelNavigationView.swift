//
//  CancelNavigationView.swift
//  Woods
//
//  Created by Fredrik on 05.01.22.
//  Copyright © 2022 Fredrik. All rights reserved.
//

import SwiftUI

struct CancelNavigationView<Inner>: View where Inner: View {
    let title: String
    let onCancel: () -> Void
    @ViewBuilder let inner: () -> Inner
    
    var body: some View {
        NavigationView {
            inner()
                .navigationTitle(title)
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            onCancel()
                        }
                    }
                }
                #endif
        }
    }
}

struct CancelNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CancelNavigationView(title: "Test") {
            print("Cancelled")
        } inner: {
            Text("Test")
        }
    }
}
