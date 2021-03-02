//
//  GeocacheLog.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Foundation

struct GeocacheLog: Identifiable, Hashable, Codable {
    let id: UUID // on Geocaching.com this should match the LUID
    let type: GeocacheLogType
    let username: String // TODO: More detailed user info
    let content: String
}
