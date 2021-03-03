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
        }
        .font(.caption)
    }
}

struct WaypointDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WaypointDetailView(waypoint: mockGeocaches().first!)
    }
}
