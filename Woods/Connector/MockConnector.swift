//
//  MockConnector.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik.
//

import Foundation
import Combine

/// A simple connector that outputs some fake caches for testing.
final class MockConnector: Connector {
    init() {}
    
    init(using credentials: Credentials) {}
    
    func waypoint(id: String) throws -> Waypoint {
        guard let cache = mockGeocaches().first(where: { $0.id == id }) else { throw ConnectorError.waypointNotFound(id) }
        return cache
    }
    
    func waypoints(for query: WaypointsInRadiusQuery) -> [Waypoint] {
        mockGeocaches().filter { $0.location.distance(to: query.center) <= query.radius }
    }
    
    func waypoints(for query: WaypointsInRegionQuery) -> [Waypoint] {
        mockGeocaches().filter { query.region.contains($0.location) }
    }
}
