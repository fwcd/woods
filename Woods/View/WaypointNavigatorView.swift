//
//  WaypointNavigatorView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointNavigatorView: View {
    let target: Coordinates
    
    @EnvironmentObject private var locationManager: LocationManager
    
    private var location: Coordinates? {
        locationManager.location.map { Coordinates(from: $0.coordinate) }
    }
    private var heading: Degrees? {
        locationManager.heading.map { Degrees(radians: atan2($0.y, $0.x)) }
    }
    private var accuracy: Length? {
        (locationManager.location?.horizontalAccuracy).map { Length(meters: $0) }
    }
    private var distanceToTarget: Length? {
        location.map { $0.distance(to: target) }
    }
    private var headingToTarget: Degrees? {
        heading.flatMap { h in location.map { h + $0.heading(to: target) } }
    }
    private var distance: Length? { Length(10, .kilometers) }
    
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: "location.north.fill")
                .font(.system(size: 128))
                .rotationEffect(.degrees(headingToTarget?.totalDegrees ?? 0))
            VStack {
                if let distance = distanceToTarget {
                    Text(distance.description)
                        .font(.title)
                }
                if let accuracy = accuracy {
                    Text("+- \(accuracy.description)")
                        .font(.title2)
                }
            }
        }
    }
}

struct WaypointNavigatorView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        WaypointNavigatorView(target: mockGeocaches().first!.location)
            .environmentObject(locationManager)
    }
}
