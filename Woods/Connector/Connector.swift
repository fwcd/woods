//
//  Connector.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import Combine

/// A proxy for a connection to a remote waypoint/geocache service.
protocol Connector: AnyObject {
    /// Logs into the service.
    init(using credentials: Credentials) async throws
    
    /// Fetches infomation about the account.
    func accountInfo() async throws -> AccountInfo
    
    /// Posts a log.
    func post(waypointLog: WaypointLog, for waypoint: Waypoint) async throws -> WaypointLog
    
    /// Fetches a waypoint with the given id.
    func waypoint(id: String) async throws -> Waypoint
    
    /// Fetches waypoints within the given radius.
    func waypoints(for query: WaypointsInRadiusQuery) async throws -> [Waypoint]
    
    /// Fetches waypoints within the given region.
    func waypoints(for query: WaypointsInRegionQuery) async throws -> [Waypoint]
}

extension Connector {
    func post(waypointLog: WaypointLog, for waypoint: Waypoint) throws -> WaypointLog {
        throw ConnectorError.postingLogsNotSupported
    }
    
    func accountInfo() -> AccountInfo { AccountInfo() }
}
