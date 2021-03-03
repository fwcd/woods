//
//  GeocacheDetailView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointDetailView: View {
    let waypoint: Waypoint
    
    @State private var listPickerSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    
    var body: some View {
        VStack(alignment: .leading) {
            WaypointSnippetView(waypoint: waypoint)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Form {
                Section(header: Text("Info")) {
                    Text(waypoint.location.description)
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        StarsView(
                            rating: waypoint.difficulty ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                        Divider()
                        Image(systemName: "leaf.fill")
                        StarsView(
                            rating: waypoint.terrain ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                    }
                }
                if let description = waypoint.description {
                    Section(header: Text("Description")) {
                        Text(description)
                    }
                }
                if let hint = waypoint.hint {
                    Section(header: Text("Hint")) {
                        Text(hint)
                    }
                }
                if waypoint.placedAt != nil || waypoint.lastFoundAt != nil {
                    let formatter = makeDateFormatter()
                    Section(header: Text("Dates")) {
                        if let placedAt = waypoint.placedAt {
                            Text("Placed: \(formatter.string(from: placedAt))")
                        }
                        if let lastFoundAt = waypoint.lastFoundAt {
                            Text("Last Found: \(formatter.string(from: lastFoundAt))")
                        }
                    }
                }
                if !waypoint.additionalWaypoints.isEmpty {
                    Section(header: Text("Additional Waypoints")) {
                        List(waypoint.additionalWaypoints) { waypoint in
                            WaypointSmallSnippetView(waypoint: waypoint)
                        }
                    }
                }
                Section(header: Text("Actions")) {
                    Button(action: { listPickerSheetShown = true }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add To List")
                        }
                    }
                    .sheet(isPresented: $listPickerSheetShown) {
                        WaypointListPickerView { id in
                            waypoints.listTree[id]?.add(waypoints: [waypoint])
                            listPickerSheetShown = false
                        }
                    }
                    // TODO: Share sheet using GPX
                }
                if !waypoint.logs.isEmpty {
                    Section(header: Text("Logs")) {
                        List(waypoint.logs) { log in
                            WaypointLogView(waypointLog: log)
                        }
                    }
                }
            }
        }
    }
    
    private func makeDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
}

struct GeocacheDetailView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
            .environmentObject(locationManager)
            .environmentObject(waypoints)
    }
}
