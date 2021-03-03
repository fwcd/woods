//
//  WaypointDetailActionsView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointDetailActionsView: View {
    let waypoint: Waypoint
    
    @State private var listPickerSheetShown: Bool = false
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
            }
            if let url = waypoint.webUrl {
                Button(action: {
                    ShareSheet(items: [url]).presentIndependently()
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Link")
                    }
                }
            }
            Button(action: {
                // TODO
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
