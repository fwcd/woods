//
//  NewWaypointListView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct NewWaypointListView: View {
    let onCommit: (WaypointList) -> Void
    
    @State private var text: String = ""
    
    var body: some View {
        AutoFocusTextField(placeholder: "Name", text: $text) {
            onCommit(WaypointList(name: text))
        }
        .font(.title)
    }
}

struct NewWaypointListView_Previews: PreviewProvider {
    static var previews: some View {
        NewWaypointListView { _ in }
    }
}
