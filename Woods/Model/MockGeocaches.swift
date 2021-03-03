//
//  MockGeocaches.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

func mockGeocaches() -> [Waypoint] {
    [
        // TODO: Use fixed dates and uuids for logs
        Waypoint(
            id: "MOCK1",
            name: "Test Cache",
            location: Coordinates(latitude: 52.50733, longitude: 13.42806),
            difficulty: 2,
            terrain: 3,
            geocacheType: .traditional,
            webUrl: URL(string: "https://example.com"),
            logs: [
                WaypointLog(type: .found, username: "Alice", content: "Very nice cache, thanks!"),
                WaypointLog(type: .didNotFind, username: "Bob", content: "Long search, no find. :("),
                WaypointLog(type: .found, username: "Charles", content: "TFTC"),
                WaypointLog(type: .ownerMaintenance, username: "Dave", content: "Thanks for the note!"),
                WaypointLog(type: .needsMaintenance, username: "Erik", content: "The logbook should probably be replaced."),
            ]
        ),
        Waypoint(
            id: "MOCK2",
            name: "Lake View",
            location: Coordinates(latitude: 51.30563, longitude: 7.94576),
            difficulty: 2,
            terrain: 4,
            geocacheType: .multi,
            additionalWaypoints: [
                Waypoint(id: "WP1", name: "A nice café", location: Coordinates(latitude: 51.306723, longitude: 7.941415)),
                Waypoint(id: "WP2", name: "Trail", location: Coordinates(latitude: 51.306120, longitude: 7.949290)),
            ]
        ),
        Waypoint(
            id: "MOCK3",
            name: "Mountain Views",
            location: Coordinates(latitude: 46.89705, longitude: 7.97048),
            difficulty: 10,
            terrain: 10,
            geocacheType: .earth
        ),
        Waypoint(
            id: "MOCK4",
            name: "Ferry to Oslo",
            location: Coordinates(latitude: 54.32851, longitude: 10.15303),
            difficulty: 5,
            terrain: 10,
            geocacheType: .mystery
        ),
    ]
}
