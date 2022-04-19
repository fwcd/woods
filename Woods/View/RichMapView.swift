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
    
    private var filteredWaypoints: [Waypoint] {
        waypoints.sortedWaypoints.filter { waypoint in
            searchText.isEmpty || waypoint.matches(searchQuery: searchText)
        }
    }
    
    private enum ListPickerMode {
        case open
        case save
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
            VStack(spacing: 10) {
                Button(action: {
                    if let region = region {
                        Task {
                            await waypoints.refresh(with: query(from: region))
                        }
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
                    Task {
                        await waypoints.queryDetails(for: id)
                    }
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
