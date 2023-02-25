//
//  WaypointSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointSnippetView: View {
    let waypoint: Waypoint
    
    @EnvironmentObject private var locationManager: LocationManager
    @State private var navigatorSheetShown: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: waypoint.iconName)
                .foregroundColor(waypoint.color)
                .font(.title)
            VStack(alignment: .leading) {
                Text(waypoint.id)
                    .font(.headline)
                    .textSelection(.enabled)
                Text(waypoint.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
            }
            Spacer()
            if let location = locationManager.location {
                Button(action: { navigatorSheetShown = true }) {
                    WaypointDistanceView(start: location, target: waypoint.location)
                }
                .sheet(isPresented: $navigatorSheetShown) {
                    CancelNavigationStack(title: "Navigator") {
                        navigatorSheetShown = false
                    } inner: {
                        WaypointLocatingNavigatorView(target: waypoint.location)
                            .environmentObject(locationManager)
                    }
                }
            }
        }
        .onAppear {
            locationManager.dependOnLocation()
        }
        .onDisappear {
            locationManager.undependOnLocation()
        }
    }
}

struct WaypointSnippetView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        WaypointSnippetView(waypoint: mockGeocaches().first!)
            .environmentObject(locationManager)
    }
}
