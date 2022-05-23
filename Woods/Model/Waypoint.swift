//
//  Waypoint.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import CoreGPX
import Foundation

struct Waypoint: Identifiable, Codable, Hashable {
    static let ratings: ClosedRange<Int> = 0...10
    
    var id: String = "" // GC-Code, UUID or similar
    var name: String = ""
    var location: Coordinates = Coordinates()
    var isStub: Bool = false // Whether the data is incomplete
    var difficulty: Int? = nil // half stars, between 2 and 10 (see maxRating)
    var terrain: Int? = nil    // half stars, between 2 and 10 (see maxRating)
    var geocacheType: GeocacheType? = nil
    var geocacheSize: GeocacheSize? = nil
    var status: WaypointStatus? = nil
    var attributes: [WaypointAttribute: Bool] = [:]
    var owner: String? = nil
    var placedAt: Date? = nil
    var lastFoundAt: Date? = nil
    var insertedAt: Date? = nil
    var favorites: Int = 0
    var found: Bool = false
    var didNotFind: Bool = false
    var enabled: Bool = true
    var premiumOnly: Bool = false
    var summary: String? = nil
    var description: String? = nil
    var hint: String? = nil
    var webUrl: URL? = nil
    var logs: [WaypointLog] = []
    var additionalWaypoints: [Waypoint] = []
    
    var asGPXRoot: GPXRoot {
        let root = GPXRoot(creator: "Woods")
        let wp = GPXWaypoint(latitude: location.latitude.totalDegrees, longitude: location.longitude.totalDegrees)
        wp.name = id
        wp.desc = name
        wp.time = placedAt
        wp.comment = description
        root.add(waypoint: wp)
        // TODO: Groundspeak attributes
        return root
    }
    var asGPX: String {
        asGPXRoot.gpx()
    }
    
    func matches(searchQuery: String) -> Bool {
        let lowerQuery = searchQuery.lowercased()
        return [id, name, summary].compactMap { $0?.lowercased() }.contains { $0.contains(lowerQuery) }
    }
    
    mutating func generateIdIfEmpty() {
        if id.isEmpty {
            id = "WP\(String(Int.random(in: 0..<1_000_000_000), radix: 16).uppercased())"
        }
    }
}
