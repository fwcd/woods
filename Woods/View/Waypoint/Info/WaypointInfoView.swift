//
//  WaypointInfoView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointInfoView: View {
    let waypoint: Waypoint
    
    var body: some View {
        Text(waypoint.location.description)
            .textSelection(.enabled)
        HStack(spacing: 20) {
            if let difficulty = waypoint.difficulty {
                VStack {
                    StarsView(
                        rating: difficulty,
                        maxRating: Waypoint.ratings.upperBound,
                        step: 2
                    )
                    Text("Difficulty")
                }
            }
            if let terrain = waypoint.terrain {
                VStack {
                    StarsView(
                        rating: terrain,
                        maxRating: Waypoint.ratings.upperBound,
                        step: 2
                    )
                    Text("Terrain")
                }
            }
            if let geocacheSize = waypoint.geocacheSize {
                VStack {
                    SizeView(
                        rating: value(of: geocacheSize),
                        maxRating: 4
                    )
                    Text("Size")
                }
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

// TODO: Preview crashes on Xcode 13.3
/*
struct WaypointDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
    }
}
*/
