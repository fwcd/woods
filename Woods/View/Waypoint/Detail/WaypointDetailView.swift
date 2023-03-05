//
//  WaypointDetailView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointDetailView: View {
    let waypoint: Waypoint
    var hasMap: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if hasMap {
                WaypointMapView(waypoints: [waypoint] + waypoint.additionalWaypoints)
                    .frame(height: 200)
                    .cornerRadius(10)
            }
            WaypointSnippetView(waypoint: waypoint)
            WaypointInfoSection(waypoint: waypoint)
            if let description = waypoint.description {
                WaypointDescriptionSection(description: description)
            }
            if let attributes = waypoint.attributes.nilIfEmpty {
                WaypointAttributeSection(attributes: attributes)
            }
            if let hint = waypoint.hint {
                WaypointHintSection(hint: hint)
            }
            if waypoint.placedAt != nil || waypoint.lastFoundAt != nil {
                WaypointDatesSection(waypoint: waypoint)
            }
            if !waypoint.additionalWaypoints.isEmpty {
                AdditionalWaypointsSection(waypoint: waypoint)
            }
            WaypointDetailActionsView(waypoint: waypoint)
            if !waypoint.logs.isEmpty || !waypoint.fetchableViaAccountTypes.isEmpty {
                WaypointLogsSection(waypoint: waypoint)
            }
        }
        .padding([.leading, .trailing], 20)
    }
}

struct WaypointDetailView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        Group {
            ScrollView {
                WaypointDetailView(waypoint: mockGeocaches().first!)
            }
            ScrollView {
                WaypointDetailView(waypoint: mockGeocaches().first!)
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(locationManager)
        .environmentObject(waypoints)
    }
}
