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
    @Published var lists: [UUID: WaypointList] = [:]
    let rootListId: UUID
    
    private let accounts: Accounts
    private var runningQueryTask: AnyCancellable?
    
    init(accounts: Accounts, lists initialLists: [WaypointList] = []) {
        self.accounts = accounts
        lists = Dictionary(uniqueKeysWithValues: initialLists.map { ($0.id, $0) })
        
        var rootList = WaypointList(name: "Lists")
        rootList.childs = initialLists.map(\.id)
        rootListId = rootList.id
        lists[rootList.id] = rootList
    }
    
    subscript(id: String) -> Waypoint? {
        waypoints[id]
    }
    
    func preOrderTraversedLists(listId: UUID) -> [WaypointList] {
        if let list = lists[listId] {
            return [list] + list.childs.flatMap(preOrderTraversedLists(listId:))
        } else {
            return []
        }
    }
    
    func preOrderTraversedLists() -> [WaypointList] {
        preOrderTraversedLists(listId: rootListId)
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
