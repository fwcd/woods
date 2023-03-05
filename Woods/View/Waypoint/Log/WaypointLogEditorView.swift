//
//  WaypointLogEditorView.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogEditorView: View {
    @Binding var waypointLog: WaypointLog
    
    var body: some View {
        Form {
            Section("Info") {
                // TODO: Add icon
                EnumPicker(selection: $waypointLog.type, label: Text("Log Type"))
                DatePicker(selection: $waypointLog.timestamp) {
                    Text("Date")
                }
            }
            
            Section("Content") {
                // TODO: HTML
                TextEditor(text: $waypointLog.content)
                    #if os(macOS)
                    .frame(height: 40)
                    #endif
            }
            
            Section("Preview") {
                WaypointLogView(waypointLog: waypointLog)
            }
        }
    }
}

struct EditWaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogEditorView(waypointLog: .constant(WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!")))
    }
}
