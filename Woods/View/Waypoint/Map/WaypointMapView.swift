//
//  WaypointMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI
import MapKit
import CoreLocation

struct WaypointMapView: View {
    let waypoints: [Waypoint]
    @Binding var selectedWaypointId: String?
    @Binding var region: MKCoordinateRegion?
    @Binding var userTrackingMode: MKUserTrackingMode
    @Binding var useSatelliteView: Bool
    
    var body: some View {
        Map(
            annotations: waypoints.map { waypoint in
                Map.Annotation(
                    tag: waypoint.id,
                    coordinate: waypoint.location.asCLCoordinate,
                    // Uncomment to show cache names on map again
                    // title: waypoint.name,
                    color: waypoint.color,
                    iconName: waypoint.iconName
                )
            },
            selection: $selectedWaypointId,
            region: $region,
            userTrackingMode: $userTrackingMode,
            useSatelliteView: $useSatelliteView,
            zoomToAnnotations: true
        )
    }
    
    init(
        waypoints: [Waypoint],
        selectedWaypointId: Binding<String?>? = nil,
        region: Binding<MKCoordinateRegion?>? = nil,
        userTrackingMode: Binding<MKUserTrackingMode>? = nil,
        useSatelliteView: Binding<Bool>? = nil
    ) {
        self.waypoints = waypoints
        _selectedWaypointId = selectedWaypointId ?? .constant(nil)
        _region = region ?? .constant(nil)
        _userTrackingMode = userTrackingMode ?? .constant(.none)
        _useSatelliteView = useSatelliteView ?? .constant(false)
    }
}

struct WaypointMapView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointMapView(waypoints: [
            Waypoint(
                id: "test",
                name: "Test",
                location: Coordinates(
                    latitude: 0,
                    longitude: 0
                )
            )
        ])
    }
}
