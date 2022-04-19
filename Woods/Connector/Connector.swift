//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import Combine

protocol Connector: AnyObject {
    func logIn(using credentials: Credentials) async throws
    
    func logOut() async throws
    
    func waypoint(id: String) async throws -> Waypoint
    
    func waypoints(for query: WaypointsInRadiusQuery) async throws -> [Waypoint]
    
    func waypoints(for query: WaypointsInRegionQuery) async throws -> [Waypoint]
}
