//
//  WaypointDetailActionsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "WaypointDetailActionsView")

struct WaypointDetailActionsView: View {
    let waypoint: Waypoint
    
    @State private var listPickerSheetShown: Bool = false
    @State private var linkShareSheetShown: Bool = false
    @State private var gpxUrl: URL? = nil
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    listPickerSheetShown = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                }
                .sheet(isPresented: $listPickerSheetShown) {
                    CancelNavigationView(title: "Pick Waypoint List") {
                        listPickerSheetShown = false
                    } inner: {
                        Form {
                            WaypointListPickerView { id in
                                waypoints.listTree[id]?.add(waypoints: [waypoint])
                                listPickerSheetShown = false
                            }
                        }
                        .navigationTitle("Add To List")
                        #if !os(macOS)
                        .navigationBarTitleDisplayMode(.inline)
                        #endif
                    }
                    .environmentObject(waypoints)
                }
            }
            #if canImport(UIKit)
            HStack {
                if let url = waypoint.webUrl {
                    Button {
                        UIApplication.shared.open(url)
                    } label: {
                        HStack {
                            Image(systemName: "safari")
                            Text("Web")
                        }
                    }
                    Button {
                        linkShareSheetShown = true
                    } label: {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Link")
                        }
                    }
                    .sheet(isPresented: $linkShareSheetShown) {
                        ShareSheet(items: [url])
                    }
                }
                Button {
                    do {
                        let url = persistenceFileURL(path: "GPX/\(waypoint.id).gpx")
                        try waypoint.asGPX.data(using: .utf8)?.smartWrite(to: url)
                        gpxUrl = url
                    } catch {
                        log.error("Could not encode write GPX: \(String(describing: error))")
                    }
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("GPX")
                    }
                }
                .sheet(item: $gpxUrl) { url in
                    ShareSheet(items: [url])
                }
            }
            #endif
        }
        .buttonStyle(LargeButtonStyle(padding: 8))
    }
}

struct WaypointDetailActionsView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
            .environmentObject(waypoints)
    }
}
