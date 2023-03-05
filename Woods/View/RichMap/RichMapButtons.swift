//
//  RichMapButtons.swift
//  Woods
//
//  Created by Fredrik on 20.04.22.
//

import SwiftUI
import MapKit

struct RichMapButtons: View {
    @Binding var selectedWaypointId: String?
    @Binding var useSatelliteView: Bool
    @Binding var region: MKCoordinateRegion?
    @Binding var userTrackingMode: MKUserTrackingMode
    
    @EnvironmentObject private var waypoints: Waypoints
    @State private var listPickerSheetShown: Bool = false
    @State private var listPickerMode: ListPickerMode = .save
    
    private enum ListPickerMode {
        case open
        case save
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                if let region = region {
                    Task {
                        await waypoints.refresh(with: query(from: region))
                    }
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
            }
            Button {
                useSatelliteView = !useSatelliteView
            } label: {
                Image(systemName: "building.2.crop.circle.fill")
            }
            Button {
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
            } label: {
                Image(systemName: "location.circle.fill")
            }
            Button {
                listPickerSheetShown = true
                listPickerMode = .save
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            Button {
                listPickerSheetShown = true
                listPickerMode = .open
            } label: {
                Image(systemName: "folder.circle.fill")
            }
        }
        .buttonStyle(.borderless)
        .foregroundColor(.primary)
        #if os(macOS)
        .font(.system(size: 30))
        #else
        .font(.system(size: 40))
        #endif
        .padding(10)
        .onChange(of: selectedWaypointId) {
            if let id = $0 {
                Task {
                    // Refreshing the individual waypoint queries its details
                    await waypoints.refresh(id)
                }
            }
        }
        .popover(isPresented: $listPickerSheetShown) {
            PopoverNavigation(title: "Pick Waypoint List") {
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
                #if canImport(UIKit)
                .navigationTitle("Pick List")
                .navigationBarTitleDisplayMode(.inline)
                #endif
            }
            .environmentObject(waypoints)
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

struct RichMapButtons_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    @State static var selectedWaypointId: String? = nil
    @State static var useSatelliteView: Bool = false
    @State static var region: MKCoordinateRegion? = nil
    @State static var userTrackingMode: MKUserTrackingMode = .none
    static var previews: some View {
        RichMapButtons(
            selectedWaypointId: $selectedWaypointId,
            useSatelliteView: $useSatelliteView,
            region: $region,
            userTrackingMode: $userTrackingMode
        )
        .environmentObject(waypoints)
    }
}
