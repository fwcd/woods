//
//  AdditionalWaypointsSection.swift
//  Woods
//
//  Created by Fredrik on 02.03.23.
//

import SwiftUI

struct AdditionalWaypointsSection: View {
    let waypoint: Waypoint
    
    var body: some View {
        SimpleSection(alignment: .leading) {
            ForEach(waypoint.additionalWaypoints) { child in
                NavigationLink(value: WaypointRoute.waypoint(child)) {
                    WaypointSmallSnippetView(waypoint: child)
                }
                .buttonStyle(.plain)
            }
        } header: {
            Label("Additional Waypoints", systemImage: "mappin.and.ellipse")
        }
    }
}

struct AdditionalWaypointsSection_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalWaypointsSection(waypoint: mockGeocaches()[1])
    }
}
