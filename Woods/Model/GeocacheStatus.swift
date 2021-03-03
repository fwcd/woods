//
//  GeocacheStatus.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

enum GeocacheStatus: String, Codable, Hashable {
    case enabled
    case disabled
    case archived
    case unpublished
}
