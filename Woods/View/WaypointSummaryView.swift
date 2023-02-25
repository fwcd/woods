//
//  WaypointSummaryView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointSummaryView: View {
    @Binding var waypoint: Waypoint
    var isEditable: Bool = true
    var contentOpacity: CGFloat = 1
    
    @State private var detailSheetShown: Bool = false
    @EnvironmentObject private var waypoints: Waypoints
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            WaypointSnippetView(waypoint: waypoint)
            Group {
                SimpleSection(header: "Info", iconName: "paperclip") {
                    WaypointDetailInfoView(waypoint: waypoint)
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
                Button(action: {
                    detailSheetShown = true
                }) {
                    HStack {
                        Spacer()
                        Text("Show Details")
                        Spacer()
                    }
                }
                .buttonStyle(LargeButtonStyle())
                .sheet(isPresented: $detailSheetShown) {
                    CancelNavigationStack(title: "Waypoint Details") {
                        detailSheetShown = false
                    } inner: {
                        NavigationWaypointDetailView(waypoint: $waypoint, isEditable: isEditable)
                        .padding([.top], 15)
                        .environmentObject(waypoints)
                        .environmentObject(locationManager)
                    }
                }
            }
            .opacity(contentOpacity)
        }
        .padding([.leading, .trailing], 20)
    }
    
    private func makeDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
}

struct WaypointSummaryView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    @StateObject static var waypoints = Waypoints(accounts: Accounts(testMode: true))
    static var previews: some View {
        Group {
            WaypointSummaryView(waypoint: .constant(mockGeocaches().first!))
                .environmentObject(locationManager)
                .environmentObject(waypoints)
        }
    }
}
