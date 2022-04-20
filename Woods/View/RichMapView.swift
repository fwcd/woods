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
    @State private var slideOverPosition: SlideOverCardPosition = .bottom
    
    private var filteredWaypoints: [Waypoint] {
        waypoints.sortedWaypoints.filter { waypoint in
            searchText.isEmpty || waypoint.matches(searchQuery: searchText)
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            WaypointMapView(
                waypoints: filteredWaypoints,
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
            let cardAnimation: Animation = .easeInOut(duration: 0.2)
            SlideOverCard(position: $slideOverPosition) { contentOpacity in
                VStack(alignment: .leading) {
                    if let id = selectedWaypointId, let waypoint = waypoints[id] {
                        // TODO: Get an actual binding to the waypoint here to enable editing
                        // (this might require modifications to the way we store waypoints in the view model, since we'd not only want to bind into the currentWaypoints, but ideally into the list it originated from, if any)
                        WaypointSummaryView(waypoint: .constant(waypoint), isEditable: false, contentOpacity: contentOpacity)
                    } else {
                        VStack(alignment: .leading, spacing: 5) {
                            SearchBar(placeholder: "Filter waypoints...", text: $searchText) {
                                if slideOverPosition == .bottom {
                                    withAnimation(cardAnimation) {
                                        slideOverPosition = .middle
                                    }
                                }
                            } onClear: {
                                if slideOverPosition == .middle {
                                    withAnimation(cardAnimation) {
                                        slideOverPosition = .bottom
                                    }
                                }
                            }
                            .padding([.bottom], 15)
                            ForEach(filteredWaypoints) { waypoint in
                                Button {
                                    selectedWaypointId = waypoint.id
                                } label: {
                                    WaypointSmallSnippetView(waypoint: waypoint)
                                }
                                .buttonStyle(.plain)
                            }
                            .opacity(contentOpacity)
                        }
                        .padding([.leading, .trailing], 15)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    if selectedWaypointId != nil {
                        withAnimation(cardAnimation) {
                            switch slideOverPosition {
                            case .bottom: slideOverPosition = .middle
                            case .middle: slideOverPosition = .top
                            default: break
                            }
                        }
                    }
                }
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
    }
}
