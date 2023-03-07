//
//  Waypoint+GPX.swift
//  Woods
//
//  Created by Fredrik on 20.09.22.
//

import Foundation
import CoreGPX

extension GPXRoot {
    convenience init(_ waypoint: Waypoint) {
        self.init(creator: "Woods")
        let wp = GPXWaypoint(latitude: waypoint.location.latitude.totalDegrees, longitude: waypoint.location.longitude.totalDegrees)
        wp.name = waypoint.id
        wp.desc = waypoint.name
        wp.time = waypoint.placedAt
        wp.comment = description
        add(waypoint: wp)
        // TODO: Groundspeak attributes
    }
}

extension Waypoint {
    var asGPX: String {
        GPXRoot(self).gpx()
    }
}
