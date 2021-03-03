//
//  Waypoint.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct Waypoint: Identifiable, Codable, Hashable {
    static let ratings: ClosedRange<Int> = 2...10
    
    var id: String // GC-Code, UUID or similar
    var name: String
    var location: Coordinates
    var difficulty: Int? = nil // half stars, between 2 and 10 (see maxRating)
    var terrain: Int? = nil    // half stars, between 2 and 10 (see maxRating)
    var geocacheType: GeocacheType? = nil
    var geocacheSize: GeocacheSize? = nil
    var geocacheStatus: GeocacheStatus? = nil
    var geocacheAttributes: GeocacheAttributes = []
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
    var logs: [WaypointLog] = []
    var additionalWaypoints: [Waypoint] = []
}
