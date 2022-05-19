//
//  WaypointLocatingNavigatorView.swift
//  Woods
//
//  Created by Fredrik on 21.04.22.
//

import SwiftUI

/// A version of WaypointNavigatorView that uses the current location and heading.
struct WaypointLocatingNavigatorView: View {
    let target: Coordinates
    
    @EnvironmentObject private var locationManager: LocationManager
    
    #if os(iOS)
    @EnvironmentObject private var watchManager: WatchManager
    #endif
    
    var body: some View {
        WaypointNavigatorView(
            location: locationManager.location,
            heading: locationManager.heading,
            accuracy: locationManager.accuracy,
            target: target
        )
        .onAppear {
            locationManager.dependOnLocation()
            locationManager.dependOnHeading()
            #if os(iOS)
            watchManager.navigationTarget = target
            #endif
        }
        .onDisappear {
            locationManager.undependOnLocation()
            locationManager.undependOnHeading()
            #if os(iOS)
            watchManager.navigationTarget = nil
            #endif
        }
    }
}

struct WaypointLocatingNavigatorView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    #if os(iOS)
    @StateObject static var watchManager = WatchManager()
    #endif
    
    static var previews: some View {
        WaypointLocatingNavigatorView(target: mockGeocaches().first!.location)
            .environmentObject(locationManager)
            #if os(iOS)
            .environmentObject(watchManager)
            #endif
    }
}
