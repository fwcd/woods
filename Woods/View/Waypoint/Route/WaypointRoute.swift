//
//  WaypointRoute.swift
//  Woods
//
//  Created by Fredrik on 05.03.23.
//

import Foundation

enum WaypointRoute: Hashable {
    case list(UUID)
    case waypoint(Waypoint)
}
