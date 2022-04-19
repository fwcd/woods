//
//  LatitudeCardinal.swift
//  Woods
//
//  Created by Fredrik on 19.04.22.
//

import Foundation

/// North or South.
enum LatitudeCardinal: String, Codable, Hashable, CaseIterable, CustomStringConvertible, SignedCardinal {
    case north = "N"
    case south = "S"
    
    var description: String { rawValue }
    
    var sign: FloatingPointSign {
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
    
    init(sign: FloatingPointSign) {
        switch sign {
        case .plus: self = .north
        case .minus: self = .south
        }
    }
}
