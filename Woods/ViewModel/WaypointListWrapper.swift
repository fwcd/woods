//
//  WaypointListWrapper.swift
//  Woods
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct WaypointListWrapper: Identifiable {
    private let waypoints: Waypoints
    let id: UUID
    
    var list: WaypointList? { waypoints.listTree[id] }
    var childs: [WaypointListWrapper]? { list?.childs.map { WaypointListWrapper(waypoints: waypoints, id: $0) }.nilIfEmpty }
    
    init(waypoints: Waypoints, id: UUID) {
        self.waypoints = waypoints
        self.id = id
    }
}
