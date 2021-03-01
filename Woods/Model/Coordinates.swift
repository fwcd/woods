//
//  Coordinates.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import CoreLocation

/// A pair of geographical coordinates on Earth.
struct Coordinates: Codable, Hashable, CustomStringConvertible {
    let latitude: Double
    let longitude: Double
    
    var description: String { "(\(latitude), \(longitude))" }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(from clCoordinate: CLLocationCoordinate2D) {
        latitude = clCoordinate.latitude
        longitude = clCoordinate.longitude
    }
    
    var asCLCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var asCLLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func distance(to rhs: Coordinates) -> Length {
        Length(meters: asCLLocation.distance(from: rhs.asCLLocation).magnitude)
    }
}
