//
//  WaypointTreeNode.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct WaypointList: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var childs: [UUID] = []
    var waypoints: [Waypoint] = []
}
