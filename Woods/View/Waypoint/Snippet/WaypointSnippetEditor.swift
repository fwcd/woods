//
//  WaypointSnippetEditor.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

import SwiftUI

struct WaypointSnippetEditor: View {
    @Binding var waypoint: Waypoint
    
    var body: some View {
        HStack(spacing: 20) {
            WaypointTypePicker(selection: $waypoint.type)
            VStack {
                TextField("ID (e.g. GC-Code)", text: $waypoint.id)
                    .font(.headline)
                Divider()
                TextField("Name", text: $waypoint.name)
                    .font(.title2)
            }
            #if os(macOS)
            .frame(width: 300)
            #endif
        }
    }
}

struct WaypointSnippetEditor_Previews: PreviewProvider {
    @State static var waypoint = mockGeocaches()[0]
    static var previews: some View {
        WaypointSnippetEditor(waypoint: $waypoint)
    }
}
