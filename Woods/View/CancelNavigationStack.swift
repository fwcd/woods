//
//  CancelNavigationStack.swift
//  Woods
//
//  Created by Fredrik on 05.01.22.
//  Copyright © 2022 Fredrik.
//

import SwiftUI

struct CancelNavigationStack<Inner>: View where Inner: View {
    let title: String
    let onCancel: () -> Void
    @ViewBuilder let inner: () -> Inner
    
    var body: some View {
        NavigationStack {
            inner()
                .navigationTitle(title)
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            onCancel()
                        }
                    }
                }
        }
        #if !os(macOS)
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}

struct CancelNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CancelNavigationStack(title: "Test") {
            print("Cancelled")
        } inner: {
            Text("Test")
        }
    }
}
