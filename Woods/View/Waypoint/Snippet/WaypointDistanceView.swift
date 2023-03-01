//
//  WaypointDistanceView.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct WaypointDistanceView: View {
    let start: Coordinates
    let target: Coordinates
    
    var distance: Length { start.distance(to: target) }
    
    var body: some View {
        // TODO: Show rotating icon (depending on heading)
        VStack {
            Image(systemName: "location.north.fill")
                .font(.system(.title))
            Text(distance.description)
                .font(.caption)
        }
    }
}

struct WaypointDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        let caches = mockGeocaches()
        WaypointDistanceView(start: caches[0].location, target: caches[1].location)
    }
}
