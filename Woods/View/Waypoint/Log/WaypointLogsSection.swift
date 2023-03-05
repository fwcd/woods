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
                if !waypoint.fetchableViaAccountTypes.isEmpty {
                    Button {
                        newLog = WaypointLog()
                        newLogSheetShown = true
                    } label: {
                        Label("New Log", systemImage: "square.and.pencil")
                    }
                    .popover(isPresented: $newLogSheetShown) {
                        PopoverNavigation(title: "New Log") {
                            newLogSheetShown = false
                        } inner: {
                            WaypointLogEditorView(
                                waypointLog: $newLog,
                                accountTypes: waypoint.fetchableViaAccountTypes
                            )
                        }
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
