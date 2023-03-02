//
//  EditWaypointLogView.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct EditWaypointLogView: View {
    @Binding var waypointLog: WaypointLog
    
    var body: some View {
        Form {
            Section("Info") {
                // TODO: Editable
                HStack {
                    Text(waypointLog.type.emoji)
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text(waypointLog.username)
                            .font(.headline)
                            .textSelection(.enabled)
                        Text("\(waypointLog.type.displayName) on \(DateFormatter.standard().string(from: waypointLog.createdAt ?? waypointLog.timestamp))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            Section("Content") {
                // TODO: HTML
                TextEditor(text: $waypointLog.content)
            }
        }
    }
}

struct EditWaypointLogView_Previews: PreviewProvider {
    static var previews: some View {
        EditWaypointLogView(waypointLog: .constant(WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!")))
    }
}
