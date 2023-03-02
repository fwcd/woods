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
                WaypointInfoSection(waypoint: waypoint)
                if let hint = waypoint.hint {
                    WaypointHintSection(hint: hint)
                }
                if waypoint.placedAt != nil || waypoint.lastFoundAt != nil {
                    WaypointDatesSection(waypoint: waypoint)
                }
                Button {
                    detailSheetShown = true
                } label: {
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
