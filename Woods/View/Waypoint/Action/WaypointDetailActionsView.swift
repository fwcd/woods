//
//  WaypointDetailActionsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import FlowStackLayout
import SwiftUI
import OSLog

private let log = Logger(subsystem: "Woods", category: "WaypointDetailActionsView")

struct WaypointDetailActionsView: View {
    let waypoint: Waypoint
    
    @State private var listPickerSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        FlowStack {
            Button {
                listPickerSheetShown = true
            } label: {
                Label("Add", systemImage: "plus")
            }
            .sheet(isPresented: $listPickerSheetShown) {
                CancelNavigationStack(title: "Pick Waypoint List") {
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
            #if canImport(UIKit)
            if let url = waypoint.webUrl {
                Button {
                    UIApplication.shared.open(url)
                } label: {
                    Label("Web", systemImage: "safari")
                }
                ShareLink(item: url) {
                    Label("Link", systemImage: "square.and.arrow.up")
                }
            }
            // TODO: Add subject/message to share links
            ShareLink(
                item: waypoint,
                preview: SharePreview(
                    "\(waypoint.id): \(waypoint.name)",
                    icon: Image(systemName: waypoint.iconName)
                )
            ) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            #endif
        }
        .buttonStyle(LargeButtonStyle(padding: 8))
    }
}

struct WaypointDetailActionsView_Previews: PreviewProvider {
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointDetailActionsView(waypoint: mockGeocaches().first!)
            .environmentObject(waypoints)
    }
}
