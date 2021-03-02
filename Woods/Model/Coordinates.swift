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
    let latitude: Degrees
    let longitude: Degrees
    
    var description: String { "(\(latitude), \(longitude))" }
    
    var asCLCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude.totalDegrees, longitude: longitude.totalDegrees)
    }
    var asCLLocation: CLLocation {
        CLLocation(latitude: latitude.totalDegrees, longitude: longitude.totalDegrees)
    }
    
    init(latitude: Degrees, longitude: Degrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(latitude: Double, longitude: Double) {
        self.init(latitude: Degrees(degrees: latitude), longitude: Degrees(degrees: longitude))
    }
    
    init(from clCoordinate: CLLocationCoordinate2D) {
        self.init(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
    }
    
    func distance(to rhs: Coordinates) -> Length {
        Length(meters: asCLLocation.distance(from: rhs.asCLLocation).magnitude)
    }
}
