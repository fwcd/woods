//
//  RichMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI
import MapKit
import CoreLocation

struct RichMapView: View {
    @EnvironmentObject private var waypoints: Waypoints
    @State private var selectedWaypointId: String? = nil
    @State private var region: MKCoordinateRegion? = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 50,
            longitude: 10
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 12,
            longitudeDelta: 10
        )
    )
    @State private var userTrackingMode: MKUserTrackingMode = .none
    @State private var useSatelliteView: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let cardMaxWidth: CGFloat = totalWidth < 500
                ? .infinity
                : 400
            let cardPadding: CGFloat = 20
            let useSideCardLayout = totalWidth > cardMaxWidth + (2 * cardPadding) + 150
            
            ZStack(alignment: useSideCardLayout ? .trailing : .center) {
                ZStack(alignment: .topLeading) {
                    WaypointMapView(
                        waypoints: waypoints.filteredWaypoints(for: searchText),
                        selectedWaypointId: $selectedWaypointId,
                        region: $region,
                        userTrackingMode: $userTrackingMode,
                        useSatelliteView: $useSatelliteView
                    )
                    .edgesIgnoringSafeArea(.all)
                    RichMapButtons(
                        selectedWaypointId: $selectedWaypointId,
                        useSatelliteView: $useSatelliteView,
                        region: $region,
                        userTrackingMode: $userTrackingMode
                    )
                }
                RichMapSlideOver(
                    selectedWaypointId: $selectedWaypointId,
                    searchText: $searchText
                )
                .frame(maxWidth: cardMaxWidth)
                .padding(.horizontal, useSideCardLayout ? cardPadding : 0)
            }
        }
    }
}

struct RichMapView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        RichMapView()
            .environmentObject(waypoints)
            .environmentObject(locationManager)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
