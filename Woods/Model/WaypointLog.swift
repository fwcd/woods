//
//  WaypointLog.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import Foundation

struct WaypointLog: Identifiable, Hashable, Codable {
    var id: UUID = UUID() // on Geocaching.com this should match the LUID
    var type: WaypointLogType = .found
    var date: Date? = Date()
    var createdAt: Date? = nil
    var lastEditedAt: Date? = nil
    var username: String = "" // TODO: More detailed user info
    var content: String = ""
}
