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
            SimpleSection {
                WaypointDetailInfoView(waypoint: waypoint)
            } header: {
                Label("Info", systemImage: "paperclip")
            }
            if let description = waypoint.description {
                SimpleSection {
                    LightHTMLView(html: description)
                } header: {
                    Label("Description", systemImage: "newspaper.fill")
                }
            }
            if let attributes = waypoint.attributes.nilIfEmpty {
                SimpleSection {
                    WaypointAttributeGridView(attributes: attributes)
                } header: {
                    Label("Attributes", systemImage: "tag.fill")
                }
            }
            if let hint = waypoint.hint {
                SimpleSection {
                    Text(hint)
                        .textSelection(.enabled)
                } header: {
                    Label("Hint", systemImage: "lightbulb.fill")
                }
            }
            if waypoint.placedAt != nil || waypoint.lastFoundAt != nil {
                let formatter = makeDateFormatter()
                SimpleSection {
                    if let placedAt = waypoint.placedAt {
                        Text("Placed: \(formatter.string(from: placedAt))")
                    }
                    if let lastFoundAt = waypoint.lastFoundAt {
                        Text("Last Found: \(formatter.string(from: lastFoundAt))")
                    }
                } header: {
                    Label("Dates", systemImage: "calendar")
                }
            }
            if !waypoint.additionalWaypoints.isEmpty {
                SimpleSection(alignment: .leading) {
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
                } header: {
                    Label("Additional Waypoints", systemImage: "mappin.and.ellipse")
                }
            }
            SimpleSection {
                WaypointDetailActionsView(waypoint: waypoint)
            }
            if !waypoint.logs.isEmpty {
                SimpleSection {
                    WaypointLogsView(waypoint: waypoint)
                        .frame(maxWidth: .infinity)
                } header: {
                    Label("Logs", systemImage: "book.closed.fill")
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
