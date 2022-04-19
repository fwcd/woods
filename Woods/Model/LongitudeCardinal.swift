//
//  LongitudeCardinal.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import Foundation

/// East or West.
enum LongitudeCardinal: String, Codable, Hashable, CustomStringConvertible {
    case east = "E"
    case west = "W"
    
    var description: String { rawValue }
    var asCardinal: Cardinal {
        switch self {
        case .east: return .east
        case .west: return .west
        }
    }
}
