//
//  RichMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct RichMapView: View {
    @EnvironmentObject private var waypoints: Waypoints
    @State private var selectedWaypointId: String? = nil
    @State private var region: MKCoordinateRegion? = nil
    @State private var userTrackingMode: MKUserTrackingMode = .follow
    @State private var useSatelliteView: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            WaypointMapView(
                waypoints: waypoints.waypoints.values.sorted { $0.id < $1.id },
                selectedWaypointId: $selectedWaypointId,
                region: $region,
                userTrackingMode: $userTrackingMode,
                useSatelliteView: $useSatelliteView
            )
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                Button(action: {
                    if let region = region {
                        waypoints.refresh(with: query(from: region))
                    }
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                Button(action: {
                    useSatelliteView = !useSatelliteView
                }) {
                    Image(systemName: "building.2.crop.circle.fill")
                }
                Button(action: {
                    switch userTrackingMode {
                    case .none: userTrackingMode = .follow
                    case .follow: userTrackingMode = .followWithHeading
                    case .followWithHeading: userTrackingMode = .none
                    @unknown default: userTrackingMode = .follow
                    }
                }) {
                    Image(systemName: "location.circle.fill")
                }
            }
            .foregroundColor(.primary)
            .font(.system(size: 40))
            .padding(10)
            SlideOverCard {
                VStack {
                    if let id = selectedWaypointId, let waypoint = waypoints[id] {
                        WaypointDetailView(waypoint: waypoint)
                    } else {
                        SearchBar(placeholder: "Search for waypoints...", text: $searchText)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func query(from region: MKCoordinateRegion) -> WaypointsInRadiusQuery {
        let center = region.center
        let span = region.span
        let topLeft = CLLocation(
            latitude: center.latitude - (span.latitudeDelta / 2),
            longitude: center.longitude - (span.longitudeDelta / 2)
        )
        let bottomRight = CLLocation(
            latitude: center.latitude + (span.latitudeDelta / 2),
            longitude: center.longitude + (span.longitudeDelta / 2)
        )
        let diameter = topLeft.distance(from: bottomRight).magnitude
        let query = WaypointsInRadiusQuery(
            center: Coordinates(from: center),
            radius: Length(meters: diameter / 2)
        )
        return query
    }
}

struct RichMapView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        RichMapView()
            .environmentObject(waypoints)
            .environmentObject(locationManager)
    }
}
