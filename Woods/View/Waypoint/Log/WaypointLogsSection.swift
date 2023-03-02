//
//  WaypointLogsSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct WaypointLogsSection: View {
    let waypoint: Waypoint
    
    @State private var newLogSheetShown = false
    @State private var newLog = WaypointLog()
    
    var body: some View {
        SimpleSection {
            WaypointLogsView(waypoint: waypoint)
                .frame(maxWidth: .infinity)
        } header: {
            HStack {
                Label("Logs", systemImage: "book.closed.fill")
                Spacer()
                Button {
                    newLog = WaypointLog()
                    newLogSheetShown = true
                } label: {
                    Label("New Log", systemImage: "square.and.pencil")
                }
                .sheet(isPresented: $newLogSheetShown) {
                    CancelNavigationStack(title: "New Log") {
                        newLogSheetShown = false
                    } inner: {
                        WaypointLogEditorView(waypointLog: $newLog)
                    }
                }
            }
        }
    }
}

struct WaypointLogsSection_Previews: PreviewProvider {
    static var previews: some View {
        WaypointLogsSection(waypoint: mockGeocaches()[0])
    }
}
