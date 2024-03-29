//
//  WaypointTreeNode.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

struct WaypointList: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var childs: [UUID] = []
    var waypoints: [Waypoint] = []
    
    mutating func add(waypoints newWaypoints: [Waypoint]) {
        let existingIds = Set(waypoints.map(\.id))
        waypoints += newWaypoints.filter { !existingIds.contains($0.id) }
    }
    
    mutating func moveWaypoints(fromOffsets offsets: IndexSet, toOffset offset: Int) {
        waypoints.move(fromOffsets: offsets, toOffset: offset)
    }
    
    mutating func removeWaypoints(atOffsets offsets: IndexSet) {
        waypoints.remove(atOffsets: offsets)
    }
    
    mutating func clearWaypoints() {
        waypoints = []
    }
}
