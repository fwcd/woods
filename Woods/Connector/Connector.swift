//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import Combine

protocol Connector: AnyObject {
    func logIn(using credentials: Credentials) -> AnyPublisher<Void, Error>
    
    func logOut() -> AnyPublisher<Void, Error>
    
    func waypoint(id: String) -> AnyPublisher<Waypoint, Error>
    
    func waypoints(for query: WaypointsInRadiusQuery) -> AnyPublisher<[Waypoint], Error>
    
    func waypoints(for query: WaypointsInRegionQuery) -> AnyPublisher<[Waypoint], Error>
}
