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
    @Published private(set) var waypoints: [String: Waypoint] = [:] // by id (aka. GC code)
    @Published var rootList = WaypointList(name: "Root")
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    init(accounts: Accounts) {
        self.accounts = accounts
    }
    
    subscript(id: String) -> Waypoint? {
        waypoints[id]
    }
    
    func refresh(with query: WaypointsInRadiusQuery) {
        log.info("Refreshing waypoints in a radius of \(query.radius) around \(query.center)")
        runningQueryTask = Publishers.MergeMany(accounts.connectors.values.map { $0.waypoints(for: query) })
            .collect()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    log.warning("Could not query waypoints: \(String(describing: error))")
                }
            } receiveValue: { [self] in
                let foundWaypoints = $0.flatMap { $0 }
                waypoints = Dictionary(uniqueKeysWithValues: foundWaypoints.map { ($0.id, $0) })
                log.info("Found \(foundWaypoints.count) waypoint(s)")
            }
    }
}
