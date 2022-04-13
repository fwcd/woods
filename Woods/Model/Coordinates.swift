//
//  Coordinates.swift
//  Woods
//
//  Created by Fredrik on 2/13/21.
//  Copyright © 2021 Fredrik.
//

import CoreLocation

/// A pair of geographical coordinates on Earth.
struct Coordinates: Codable, Hashable, CustomStringConvertible {
    var latitude: Degrees
    var longitude: Degrees
    
    var northSouth: CardinalDirection {
        get { latitude.totalDegrees.sign == .plus ? .north : .south }
        set {
            switch newValue {
            case .north:
                latitude.totalDegrees = abs(latitude.totalDegrees)
            case .south:
                latitude.totalDegrees = -abs(latitude.totalDegrees)
            default:
                fatalError("Invalid direction for north/south: \(newValue)")
            }
        }
    }
    var eastWest: CardinalDirection {
        get { longitude.totalDegrees.sign == .plus ? .east : .west }
        set {
            switch newValue {
            case .east:
                longitude.totalDegrees = abs(longitude.totalDegrees)
            case .west:
                longitude.totalDegrees = -abs(longitude.totalDegrees)
            default:
                fatalError("Invalid direction for east/west: \(newValue)")
            }
        }
    }
    
    var description: String { "\(northSouth) \(latitude.magnitude), \(eastWest) \(longitude.magnitude)" }
    
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
    
    func heading(to rhs: Coordinates) -> Degrees {
        // Source: https://stackoverflow.com/questions/3932502/calculate-angle-between-two-latitude-longitude-points
        let (lat1, lon1) = (latitude.totalRadians, longitude.totalRadians)
        let (lat2, lon2) = (rhs.latitude.totalRadians, rhs.longitude.totalRadians)
        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        return Degrees(radians: atan2(y, x))
    }
}
