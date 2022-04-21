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
    
    private var location: Coordinates? {
        locationManager.location.map { Coordinates(from: $0.coordinate) }
    }
    private var heading: Degrees? {
        locationManager.heading.map { Degrees(degrees: $0.trueHeading) }
    }
    private var accuracy: Length? {
        (locationManager.location?.horizontalAccuracy).map { Length(meters: $0) }
    }
    
    var body: some View {
        WaypointNavigatorView(
            location: location,
            heading: heading,
            accuracy: accuracy,
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
