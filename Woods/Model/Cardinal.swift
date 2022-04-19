//
//  Cardinal.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

/// One of the four main compass directions.
enum Cardinal: String, Codable, Hashable, CustomStringConvertible {
    case north = "N"
    case west = "W"
    case south = "S"
    case east = "E"
    
    var description: String { rawValue }
}
