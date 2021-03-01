//
//  Coordinates.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import CoreLocation

/// A pair of geographical coordinates on Earth.
struct Coordinates: Codable, Hashable {
    let latitude: Double
    let longitude: Double
    
    var usingCoreLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
