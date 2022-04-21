//
//  WaypointNavigatorView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

/// A navigation arrow from the given 'current' location to the given 'target'. Does not depend on CoreLocation.
struct WaypointNavigatorView: View {
    let location: Coordinates?
    let heading: Degrees?
    let accuracy: Length?
    let target: Coordinates
    
    private var distanceToTarget: Length? {
        location.map { $0.distance(to: target) }
    }
    private var headingToTarget: Degrees? {
        heading.flatMap { h in location.map { $0.heading(to: target) - h } }
    }
    private var distance: Length? { Length(10, .kilometers) }
    
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: "location.north.fill")
                #if os(watchOS)
                .font(.system(size: 64))
                #else
                .font(.system(size: 128))
                #endif
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
        WaypointNavigatorView(
            location: Coordinates(),
            heading: .zero,
            accuracy: .zero,
            target: mockGeocaches().first!.location
        )
        .environmentObject(locationManager)
    }
}
