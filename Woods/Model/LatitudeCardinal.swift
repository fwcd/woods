//
//  LatitudeCardinal.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import Foundation

/// North or South.
enum LatitudeCardinal: String, Codable, Hashable, CustomStringConvertible {
    case north = "N"
    case south = "S"
    
    var description: String { rawValue }
    var asCardinal: Cardinal {
        switch self {
        case .north: return .north
        case .south: return .south
        }
    }
}
