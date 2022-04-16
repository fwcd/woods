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
    @State private var listPickerSheetShown: Bool = false
    @State private var listPickerMode: ListPickerMode = .save
    @State private var searchText: String = ""
    @State private var slideOverPosition: SlideOverCardPosition = .bottom
    
    private enum ListPickerMode {
        case open
        case save
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            WaypointMapView(
                waypoints: waypoints.sortedWaypoints,
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
                    #if os(macOS)
                    case .follow: userTrackingMode = .none
                    #else
                    case .follow: userTrackingMode = .followWithHeading
                    case .followWithHeading: userTrackingMode = .none
                    #endif
                    default: userTrackingMode = .follow
                    }
                }) {
                    Image(systemName: "location.circle.fill")
                }
                Button(action: {
                    listPickerSheetShown = true
                    listPickerMode = .save
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                Button(action: {
                    listPickerSheetShown = true
                    listPickerMode = .open
                }) {
                    Image(systemName: "folder.circle.fill")
                }
            }
            .foregroundColor(.primary)
            .font(.system(size: 40))
            .padding(10)
            .onChange(of: selectedWaypointId) {
                if let id = $0 {
                    waypoints.queryDetails(for: id)
                }
            }
            .sheet(isPresented: $listPickerSheetShown) {
                CancelNavigationView(title: "Pick Waypoint List") {
                    listPickerSheetShown = false
                } inner: {
                    Form {
                        WaypointListPickerView { id in
                            switch listPickerMode {
                            case .save:
                                waypoints.listTree[id]?.add(waypoints: waypoints.currentWaypoints.values.sorted { $0.name < $1.name })
                            case .open:
                                if let list = waypoints.listTree[id] {
                                    waypoints.update(currentWaypoints: list.waypoints)
                                }
                            }
                            listPickerSheetShown = false
                        }
                    }
                    .navigationTitle("Pick List")
                    #if canImport(UIKit)
                    .navigationBarTitleDisplayMode(.inline)
                    #endif
                }
                .environmentObject(waypoints)
            }
            SlideOverCard(position: $slideOverPosition) { contentOpacity in
                VStack(alignment: .leading) {
                    if let id = selectedWaypointId, let waypoint = waypoints[id] {
                        WaypointSummaryView(waypoint: waypoint, contentOpacity: contentOpacity)
                    } else {
                        VStack(alignment: .leading, spacing: 5) {
                            SearchBar(placeholder: "Filter waypoints...", text: $searchText)
                                .padding([.bottom], 15)
                            ForEach(waypoints.sortedWaypoints) { waypoint in
                                if searchText.isEmpty || waypoint.matches(searchQuery: searchText) {
                                    Button {
                                        selectedWaypointId = waypoint.id
                                    } label: {
                                        WaypointSmallSnippetView(waypoint: waypoint)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 15)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    if selectedWaypointId != nil {
                        withAnimation(.easeInOut(duration: 0.2)) {
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
    
    private func query(from region: MKCoordinateRegion) -> WaypointsInRegionQuery {
        let center = region.center
        let span = region.span
        let topLeft = CLLocation(
            latitude: center.latitude + (span.latitudeDelta / 2),
            longitude: center.longitude - (span.longitudeDelta / 2)
        )
        let bottomRight = CLLocation(
            latitude: center.latitude - (span.latitudeDelta / 2),
            longitude: center.longitude + (span.longitudeDelta / 2)
        )
        return WaypointsInRegionQuery(
            region: Region(
                topLeft: Coordinates(from: topLeft.coordinate),
                bottomRight: Coordinates(from: bottomRight.coordinate)
            )
        )
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
