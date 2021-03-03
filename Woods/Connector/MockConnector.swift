//
//  MockConnector.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import Combine

/// A simple connector that outputs some fake caches for testing.
class MockConnector: Connector {
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error> {
        Just(()).weakenError().eraseToAnyPublisher()
    }
    
    func logOut() -> AnyPublisher<Void, Error> {
        Just(()).weakenError().eraseToAnyPublisher()
    }
    
    func waypoint(id: String) -> AnyPublisher<Waypoint, Error> {
        Result.Publisher(Result {
            guard let cache = mockGeocaches().first(where: { $0.id == id }) else { throw ConnectorError.waypointNotFound(id) }
            return cache
        }).eraseToAnyPublisher()
    }
    
    func waypoints(for query: WaypointsInRadiusQuery) -> AnyPublisher<[Waypoint], Error> {
        Just(mockGeocaches().filter { $0.location.distance(to: query.center) <= query.radius }).weakenError().eraseToAnyPublisher()
    }
    
    func waypoints(for query: WaypointsInRegionQuery) -> AnyPublisher<[Waypoint], Error> {
        Just(mockGeocaches().filter { query.region.contains($0.location) }).weakenError().eraseToAnyPublisher()
    }
}
