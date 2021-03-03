//
//  WaypointDetailActionsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "WaypointDetailActionsView")

struct WaypointDetailActionsView: View {
    let waypoint: Waypoint
    
    @State private var listPickerSheetShown: Bool = false
    @State private var linkShareSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        HStack {
            Button(action: { listPickerSheetShown = true }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add To List")
                }
            }
            .sheet(isPresented: $listPickerSheetShown) {
                NavigationView {
                    Form {
                        WaypointListPickerView { id in
                            waypoints.listTree[id]?.add(waypoints: [waypoint])
                            listPickerSheetShown = false
                        }
                    }
                    .navigationTitle("Add To List")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .environmentObject(waypoints)
            }
            if let url = waypoint.webUrl {
                Button(action: { linkShareSheetShown = true }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Link")
                    }
                }
                .sheet(isPresented: $linkShareSheetShown) {
                    ShareSheet(items: [url])
                }
            }
            Button(action: {
                do {
                    let url = persistenceFileURL(path: "GPX/\(waypoint.id).gpx")
                    try waypoint.asGPX.data(using: .utf8)?.smartWrite(to: url)
                    ShareSheet(items: [url]).presentIndependently() // TODO: Make this a SwiftUI sheet too
                } catch {
                    log.error("Could not encode write GPX: \(String(describing: error))")
                }
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("GPX")
                }
            }
        }
        .buttonStyle(LargeButtonStyle())
    }
}

struct WaypointDetailActionsView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
            .environmentObject(waypoints)
    }
}
