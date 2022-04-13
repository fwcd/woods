//
//  Waypoints.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik.
//

import Foundation
import OSLog
import Combine

private let log = Logger(subsystem: "Woods", category: "Waypoints")

class Waypoints: ObservableObject {
    /// The currently presented (e.g. by a map or list) waypoints by id (aka. GC code)
    @Published private(set) var currentWaypoints: [String: Waypoint] = [:]
    @Published(persistingTo: "Waypoints/listTree.json") var listTree = WaypointListTree()
    
    private var originatingAccountIds: [String: UUID] = [:] // Waypoint id to account id
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    var listRootWrapper: WaypointListWrapper { WaypointListWrapper(waypoints: self, id: listTree.rootId) }
    
    init(accounts: Accounts, lists: [WaypointList] = []) {
        self.accounts = accounts
        
        for list in lists {
            listTree.insert(child: list)
        }
    }
    
    subscript(id: String) -> Waypoint? {
        currentWaypoints[id]
    }
    
    func update(currentWaypoints: [Waypoint]) {
        self.currentWaypoints = Dictionary(uniqueKeysWithValues: currentWaypoints.map { ($0.id, $0) })
        originatingAccountIds = [:]
    }
    
    func refresh(with query: WaypointsInRegionQuery) {
        log.info("Refreshing waypoints in the region around \(query.region.center) (diameter: \(query.region.diameter)")
        
        originatingAccountIds = [:]
        runningQueryTask = Publishers.MergeMany(accounts.connectors.map { (acc, conn) in conn.waypoints(for: query).map { ($0, acc) } })
            .collect()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not query waypoints: \(String(describing: error))")
                }
            } receiveValue: { [self] in
                let foundWaypoints = $0.flatMap { (wps, acc) in wps.map { ($0, acc) } }
                currentWaypoints = Dictionary(uniqueKeysWithValues: foundWaypoints.map { ($0.0.id, $0.0) })
                originatingAccountIds = Dictionary(uniqueKeysWithValues: foundWaypoints.map { ($0.0.id, $0.1) })
                log.info("Found \(foundWaypoints.count) waypoint(s)")
            }
    }
    
    func queryDetails(for waypointId: String) {
        if let connector = originatingAccountIds[waypointId].flatMap({ accounts.connectors[$0] }), (currentWaypoints[waypointId]?.isStub ?? true) {
            runningQueryTask = connector.waypoint(id: waypointId)
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        log.warning("Could not query details: \(String(describing: error))")
                    }
                } receiveValue: { [self] in
                    currentWaypoints[waypointId] = $0
                    log.info("Queried details for \(waypointId)")
                }
        }
    }
}
