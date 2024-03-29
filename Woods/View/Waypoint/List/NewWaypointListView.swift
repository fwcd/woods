//
//  NewWaypointListView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct NewWaypointListView: View {
    let onCommit: (WaypointList) -> Void
    
    @State private var text: String = ""
    
    var body: some View {
        #if canImport(UIKit)
        AutoFocusTextField(placeholder: "Name", text: $text) {
            onCommit(WaypointList(name: text))
        }
        .font(.title)
        #else
        TextField("Name", text: $text)
            #if os(macOS)
            .frame(width: 250)
            #endif
            .onSubmit {
                onCommit(WaypointList(name: text))
            }
        #endif
    }
}

struct NewWaypointListView_Previews: PreviewProvider {
    static var previews: some View {
        NewWaypointListView { _ in }
    }
}
