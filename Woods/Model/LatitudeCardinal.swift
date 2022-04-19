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
    var sign: Int {
        switch self {
        case .north: return 1
        case .south: return -1
        }
    }
    var fpSign: FloatingPointSign {
        switch self {
        case .north: return .plus
        case .south: return .minus
        }
    }
    var asCardinal: Cardinal {
        switch self {
        case .north: return .north
        case .south: return .south
        }
    }
    
    init?(sign: Int) {
        switch sign {
        case 1: self = .north
        case -1: self = .south
        default: return nil
        }
    }
    
    init(fpSign: FloatingPointSign) {
        switch fpSign {
        case .plus: self = .north
        case .minus: self = .south
        }
    }
}
