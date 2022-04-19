//
//  NewWaypointView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct NewWaypointView: View {
    let onCommit: (Waypoint) -> Void
    
    @State private var text: String = ""
    
    var body: some View {
        Text("TODO")
    }
}

struct NewWaypointView_Previews: PreviewProvider {
    static var previews: some View {
        NewWaypointView { _ in }
    }
}
