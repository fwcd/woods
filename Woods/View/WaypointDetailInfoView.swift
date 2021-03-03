//
//  WaypointDetailInfoView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointDetailInfoView: View {
    let waypoint: Waypoint
    
    var body: some View {
        Text(waypoint.location.description)
        HStack(spacing: 20) {
            VStack {
                StarsView(
                    rating: waypoint.difficulty ?? 0,
                    maxRating: Waypoint.ratings.upperBound,
                    step: 2
                )
                Text("Difficulty")
            }
            VStack {
                StarsView(
                    rating: waypoint.terrain ?? 0,
                    maxRating: Waypoint.ratings.upperBound,
                    step: 2
                )
                Text("Terrain")
            }
            VStack {
                SizeView(
                    rating: value(of: waypoint.geocacheSize ?? .notChosen),
                    maxRating: 4
                )
                Text("Size")
            }
        }
        .font(.caption)
    }
    
    private func value(of size: GeocacheSize) -> Int {
        switch size {
        case .nano:
            return 1
        case .micro:
            return 1
        case .small:
            return 2
        case .regular:
            return 3
        case .large:
            return 4
        default:
            return 0
        }
    }
}

struct WaypointDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
    }
}
