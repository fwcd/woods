//
//  EditableWaypointDetailView.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import SwiftUI

struct NavigationWaypointDetailView: View {
    let waypoint: Waypoint
    
    var body: some View {
        ScrollView {
            WaypointDetailView(waypoint: waypoint)
        }
        .navigationTitle("Waypoint")
    }
}

struct NavigationWaypointDetailView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        NavigationView {
            NavigationWaypointDetailView(waypoint: mockGeocaches().first!)
                .environmentObject(locationManager)
                .environmentObject(waypoints)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
