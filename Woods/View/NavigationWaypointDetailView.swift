//
//  EditableWaypointDetailView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct NavigationWaypointDetailView: View {
    @Binding var waypoint: Waypoint
    
    @State private var isEditing = false
    
    var body: some View {
        Group {
            if isEditing {
                EditWaypointView(waypoint: $waypoint) {
                    isEditing = false
                }
            } else {
                ScrollView {
                    WaypointDetailView(waypoint: waypoint)
                }
            }
        }
        .navigationTitle("Waypoint")
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isEditing = !isEditing
                } label: {
                    Text(isEditing ? "Done" : "Edit")
                }
            }
        }
    }
}

struct NavigationWaypointDetailView_Previews: PreviewProvider {
    @State private static var waypoint = mockGeocaches().first!
    @StateObject private static var locationManager = LocationManager()
    @StateObject private static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        NavigationView {
            NavigationWaypointDetailView(waypoint: $waypoint)
                .environmentObject(locationManager)
                .environmentObject(waypoints)
        }
    }
}
