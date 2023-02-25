//
//  Waypoint+GPX.swift
//  Woods
//
//  Created by Fredrik on 20.09.22.
//

import Foundation
import CoreGPX

extension Waypoint {
    var asGPXRoot: GPXRoot {
        let root = GPXRoot(creator: "Woods")
        let wp = GPXWaypoint(latitude: location.latitude.totalDegrees, longitude: location.longitude.totalDegrees)
        wp.name = id
        wp.desc = name
        wp.time = placedAt
        wp.comment = description
        root.add(waypoint: wp)
        // TODO: Groundspeak attributes
        return root
    }
    
    var asGPX: String {
        asGPXRoot.gpx()
    }
}
