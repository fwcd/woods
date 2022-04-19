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
    var sign: Int {
        switch self {
        case .east: return 1
        case .west: return -1
        }
    }
    var fpSign: FloatingPointSign {
        switch self {
        case .east: return .plus
        case .west: return .minus
        }
    }
    var asCardinal: Cardinal {
        switch self {
        case .east: return .east
        case .west: return .west
        }
    }
    
    init?(sign: Int) {
        switch sign {
        case 1: self = .east
        case -1: self = .west
        default: return nil
        }
    }
    
    init(fpSign: FloatingPointSign) {
        switch fpSign {
        case .plus: self = .east
        case .minus: self = .west
        }
    }
}
