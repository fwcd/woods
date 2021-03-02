//
//  GeocacheLog.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct GeocacheLog: Identifiable, Hashable, Codable {
    var id: UUID = UUID() // on Geocaching.com this should match the LUID
    var timestamp: Date = Date()
    var type: GeocacheLogType
    var username: String // TODO: More detailed user info
    var content: String
}