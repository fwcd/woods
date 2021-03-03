//
//  Waypoints.swift
//  Woods
//
//  Created by Fredrik on 3/1/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation
import OSLog
import Combine

private let log = Logger(subsystem: "Woods", category: "Waypoints")

class Waypoints: ObservableObject {
    /// The currently presented (e.g. by a map or list) waypoints by id (aka. GC code)
    @Published private(set) var currentWaypoints: [String: Waypoint] = [:]
    @Published(persistingTo: "Waypoints/listTree.json") var listTree = WaypointListTree()
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    init(accounts: Accounts, lists: [WaypointList] = []) {
        self.accounts = accounts
        
        for list in lists {
            listTree.insert(child: list)
        }
    }
    
    subscript(id: String) -> Waypoint? {
        currentWaypoints[id]
    }
    
    func refresh(with query: WaypointsInRegionQuery) {
        log.info("Refreshing waypoints in the region around \(query.region.center) (diameter: \(query.region.diameter)")
        runningQueryTask = Publishers.MergeMany(accounts.connectors.values.map { $0.waypoints(for: query) })
            .collect()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not query waypoints: \(String(describing: error))")
                }
            } receiveValue: { [self] in
                let foundWaypoints = $0.flatMap { $0 }
                currentWaypoints = Dictionary(uniqueKeysWithValues: foundWaypoints.map { ($0.id, $0) })
                log.info("Found \(foundWaypoints.count) waypoint(s)")
            }
    }
}
