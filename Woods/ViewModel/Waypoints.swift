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

@MainActor
class Waypoints: ObservableObject {
    /// The currently presented (e.g. by a map or list) waypoints by id (aka. GC code)
    @Published private(set) var currentWaypoints: [String: Waypoint] = [:]
    @Published(persistingTo: "Waypoints/listTree.json") var listTree = WaypointListTree()
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    var sortedWaypoints: [Waypoint] { currentWaypoints.values.sorted { $0.id < $1.id } }
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
    }
    
    func refresh(with query: WaypointsInRegionQuery) async throws {
        log.info("Refreshing waypoints in the region around \(query.region.center) (diameter: \(query.region.diameter))")
        
        let foundWaypoints = try await withThrowingTaskGroup(of: ([Waypoint], UUID).self) { group -> [(Waypoint, UUID)] in
            for (acc, login) in accounts.accountLogins {
                group.addTask {
                    (try await login.connector?.waypoints(for: query) ?? [], acc)
                }
            }
            
            var foundWaypoints: [(Waypoint, UUID)] = []
            for try await (chunk, acc) in group {
                foundWaypoints += chunk.map { ($0, acc) }
            }
            return foundWaypoints
        }
        
        currentWaypoints = Dictionary(uniqueKeysWithValues: foundWaypoints.map { ($0.0.id, $0.0) })
        log.info("Found \(foundWaypoints.count) waypoint(s)")
    }
    
    func refresh(_ waypointId: String) async {
        if let waypoint = currentWaypoints[waypointId],
           let connector = accounts.connector(for: waypoint) {
            do {
                currentWaypoints[waypointId] = try await connector.waypoint(id: waypointId)
                log.info("Refreshed \(waypointId)")
            } catch {
                log.warning("Could not refresh waypoint: \(String(describing: error))")
            }
        }
    }
    
    func filteredWaypoints(for searchText: String) -> [Waypoint] {
        sortedWaypoints.filter { waypoint in
            searchText.isEmpty || waypoint.matches(searchQuery: searchText)
        }
    }
}
