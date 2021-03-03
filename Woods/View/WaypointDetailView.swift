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
        VStack(alignment: .leading, spacing: 20) {
            WaypointSnippetView(waypoint: waypoint)
            SimpleSection(header: "Info", iconName: "paperclip") {
                Text(waypoint.location.description)
                HStack(spacing: 20) {
                    VStack {
                        StarsView(
                            rating: waypoint.difficulty ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                        Text("Difficulty")
                    }
                    VStack {
                        StarsView(
                            rating: waypoint.terrain ?? 0,
                            maxRating: Waypoint.ratings.upperBound,
                            step: 2
                        )
                        Text("Terrain")
                    }
                }
                .font(.caption)
            }
            if let description = waypoint.description {
                SimpleSection(header: "Description", iconName: "newspaper.fill") {
                    LightHTMLView(html: description)
                        .multilineTextAlignment(.leading)
                }
            }
            if let hint = waypoint.hint {
                SimpleSection(header: "Hint", iconName: "lightbulb.fill") {
                    Text(hint)
                }
            }
            if waypoint.placedAt != nil || waypoint.lastFoundAt != nil {
                let formatter = makeDateFormatter()
                SimpleSection(header: "Dates", iconName: "calendar") {
                    if let placedAt = waypoint.placedAt {
                        Text("Placed: \(formatter.string(from: placedAt))")
                    }
                    if let lastFoundAt = waypoint.lastFoundAt {
                        Text("Last Found: \(formatter.string(from: lastFoundAt))")
                    }
                }
            }
            if !waypoint.additionalWaypoints.isEmpty {
                SimpleSection(header: "Additional Waypoints", iconName: "mappin.and.ellipse") {
                    List(waypoint.additionalWaypoints) { waypoint in
                        WaypointSmallSnippetView(waypoint: waypoint)
                    }
                }
            }
            SimpleSection(header: "Actions", iconName: "ellipsis") {
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
            if !waypoint.logs.isEmpty {
                SimpleSection(header: "Logs", iconName: "book.closed.fill") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(waypoint.logs.prefix(4)) { log in
                            WaypointLogView(waypointLog: log)
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
        Group {
            WaypointDetailView(waypoint: mockGeocaches().first!)
                .environmentObject(locationManager)
                .environmentObject(waypoints)
            WaypointDetailView(waypoint: mockGeocaches().first!)
                .preferredColorScheme(.dark)
                .environmentObject(locationManager)
                .environmentObject(waypoints)
        }
    }
}
