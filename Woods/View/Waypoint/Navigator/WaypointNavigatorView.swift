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
    var location: Coordinates?
    var heading: Degrees?
    var accuracy: Length?
    var target: Coordinates
    
    private var distanceToTarget: Length? {
        location.map { $0.distance(to: target) }
    }
    private var headingToTarget: Degrees? {
        heading.flatMap { h in location.map { $0.heading(to: target) - h } }
    }
    private var distance: Length? { Length(10, .kilometers) }

    #if os(watchOS)
    var spacing: CGFloat = 20
    var arrowSize: CGFloat = 64
    var distanceFont: Font = .title2
    var accuracyFont: Font = .title3
    #else
    var spacing: CGFloat = 40
    var arrowSize: CGFloat = 128
    var distanceFont: Font = .title
    var accuracyFont: Font = .title2
    #endif
    
    var body: some View {
        VStack(spacing: spacing) {
            Image(systemName: "location.north.fill")
                .font(.system(size: arrowSize))
                .rotationEffect(.degrees(headingToTarget?.totalDegrees ?? 0))
            VStack {
                if let distance = distanceToTarget {
                    Text(distance.description)
                        .font(distanceFont)
                }
                if let accuracy = accuracy {
                    Text("\u{00B1} \(accuracy.description)")
                        .font(accuracyFont)
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
