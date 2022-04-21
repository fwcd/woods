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
        }
        .onDisappear {
            locationManager.undependOnLocation()
            locationManager.undependOnHeading()
        }
    }
}

struct WaypointLocatingNavigatorView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        WaypointLocatingNavigatorView(target: mockGeocaches().first!.location)
            .environmentObject(locationManager)
    }
}
