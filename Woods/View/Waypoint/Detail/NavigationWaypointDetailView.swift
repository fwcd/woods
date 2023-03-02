//
//  EditableWaypointDetailView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct NavigationWaypointDetailView: View {
    @Binding var waypoint: Waypoint
    var hasMap: Bool = true
    var isEditable: Bool = true
    
    @State private var editedWaypoint = Waypoint()
    @State private var isEditing = false
    
    var body: some View {
        Group {
            if isEditing {
                WaypointEditorView(waypoint: $editedWaypoint) {
                    commitEdit()
                }
            } else {
                ScrollView {
                    WaypointDetailView(waypoint: waypoint, hasMap: hasMap)
                }
            }
        }
        .navigationTitle("Waypoint Details")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                if isEditable {
                    Button {
                        if isEditing {
                            commitEdit()
                        } else {
                            beginEdit()
                        }
                    } label: {
                        Text(isEditing ? "Done" : "Edit")
                    }
                }
            }
        }
    }
    
    private func beginEdit() {
        editedWaypoint = waypoint
        isEditing = true
    }
    
    private func commitEdit() {
        waypoint = editedWaypoint
        isEditing = false
    }
}

struct NavigationWaypointDetailView_Previews: PreviewProvider {
    @State private static var waypoint = mockGeocaches().first!
    @StateObject private static var locationManager = LocationManager()
    @StateObject private static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        NavigationStack {
            NavigationWaypointDetailView(waypoint: $waypoint)
                .environmentObject(locationManager)
                .environmentObject(waypoints)
        }
    }
}
