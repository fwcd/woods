//
//  WaypointMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct WaypointMapView: View {
    let waypoints: [Waypoint]
    @Binding var selectedWaypointId: String?
    @Binding var region: MKCoordinateRegion
    @Binding var userTrackingMode: MapUserTrackingMode
    @Binding var useSatelliteView: Bool
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: waypoints
        ) { waypoint in
            MapMarker(
                coordinate: waypoint.location.asCLCoordinate,
                tint: waypoint.color
            )
        }
        // FIXME: Use selectedWaypointId binding
        // FIXME: Use useSatelliteView binding
    }
    
    init(
        waypoints: [Waypoint],
        selectedWaypointId: Binding<String?>? = nil,
        region: Binding<MKCoordinateRegion>? = nil,
        userTrackingMode: Binding<MapUserTrackingMode>? = nil,
        useSatelliteView: Binding<Bool>? = nil
    ) {
        self.waypoints = waypoints
        _selectedWaypointId = selectedWaypointId ?? .constant(nil)
        _region = region ?? .constant(MKCoordinateRegion())
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
