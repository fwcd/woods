//
//  CardinalDirection.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

enum CardinalDirection: String, Codable, Hashable, CustomStringConvertible {
    case north = "N"
    case west = "W"
    case south = "S"
    case east = "E"
    
    var description: String { rawValue }
}
