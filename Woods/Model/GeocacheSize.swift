//
//  GeocacheSize.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum GeocacheSize: String, Codable, Hashable {
    case notChosen
    case nano
    case micro
    case small
    case regular
    case large
    case virtual
    case other
}
