//
//  LongitudeCardinal.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import Foundation

/// East or West.
enum LongitudeCardinal: String, Codable, Hashable, CaseIterable, CustomStringConvertible, SignedCardinal {
    case east = "E"
    case west = "W"
    
    var description: String { rawValue }
    var sign: FloatingPointSign {
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
    
    init(sign: FloatingPointSign) {
        switch sign {
        case .plus: self = .east
        case .minus: self = .west
        }
    }
}
