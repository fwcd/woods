//
//  WaypointDetailView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointDetailView: View {
    let waypoint: Waypoint
    var hasMap: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if hasMap {
                WaypointMapView(waypoints: [waypoint] + waypoint.additionalWaypoints)
                    .frame(height: 200)
                    .cornerRadius(10)
            }
            WaypointSnippetView(waypoint: waypoint)
            SimpleSection(header: "Info", iconName: "paperclip") {
                WaypointDetailInfoView(waypoint: waypoint)
            }
            if let description = waypoint.description {
                SimpleSection(header: "Description", iconName: "newspaper.fill") {
                    LightHTMLView(html: description)
                }
            }
            if let attributes = waypoint.attributes.nilIfEmpty {
                SimpleSection(header: "Attributes", iconName: "tag.fill") {
                    WaypointAttributeGridView(attributes: attributes)
                }
            }
            if let hint = waypoint.hint {
                SimpleSection(header: "Hint", iconName: "lightbulb.fill") {
                    Text(hint)
                        .textSelection(.enabled)
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
                SimpleSection(header: "Additional Waypoints", iconName: "mappin.and.ellipse", alignment: .leading) {
                    ForEach(waypoint.additionalWaypoints) { child in
                        NavigationLink {
                            ScrollView {
                                WaypointDetailView(waypoint: child)
                            }
                            .navigationTitle("Additional Waypoint")
                        } label: {
                            WaypointSmallSnippetView(waypoint: child)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            SimpleSection(header: "Actions", iconName: "ellipsis") {
                WaypointDetailActionsView(waypoint: waypoint)
            }
            if !waypoint.logs.isEmpty {
                SimpleSection(header: "Logs", iconName: "book.closed.fill") {
                    WaypointLogsView(waypoint: waypoint)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding([.leading, .trailing], 20)
    }
    
    private func makeDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
}

struct WaypointDetailView_Previews: PreviewProvider {
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
