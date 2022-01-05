//
//  WaypointSnippetView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
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
                Text(waypoint.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            if let location = locationManager.location {
                Button(action: { navigatorSheetShown = true }) {
                    WaypointDistanceView(start: Coordinates(from: location.coordinate), target: waypoint.location)
                }
                .sheet(isPresented: $navigatorSheetShown) {
                    CancelNavigationView(title: "Navigator") {
                        navigatorSheetShown = false
                    } inner: {
                        WaypointNavigatorView(target: waypoint.location)
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
