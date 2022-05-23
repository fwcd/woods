//
//  WaypointType+Icon.swift
//  Woods
//
//  Created by Fredrik on 24.05.22.
//

import Foundation

extension WaypointType {
    var iconName: String {
        switch self {
        case .waypoint: return "flag.fill"
        default: return "archivebox.fill"
        }
    }
}
