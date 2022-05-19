//
//  LocationManager.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik.
//

import Combine
import CoreLocation
import OSLog

private let log = Logger(subsystem: "Woods", category: "LocationManager")

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var clLocation: CLLocation? = nil
    @Published private(set) var clHeading: CLHeading? = nil
    
    var location: Coordinates? { clLocation.map { Coordinates(from: $0.coordinate) } }
    var course: Degrees? { clLocation.map { Degrees(degrees: $0.course) } }
    var heading: Degrees? { clHeading.map { Degrees(degrees: $0.trueHeading) } }
    var altitude: Length? { clLocation.map { Length(meters: $0.altitude) } }
    
    var locationAccuracy: Length? { clLocation.map { Length(meters: $0.horizontalAccuracy) } }
    var courseAccuracy: Degrees? { clLocation.map { Degrees(degrees: $0.courseAccuracy) } }
    var headingAccuracy: Degrees? { clHeading.map { Degrees(degrees: $0.headingAccuracy) } }
    var altitudeAccuracy: Length? { clLocation.map { Length(meters: $0.verticalAccuracy) } }
    
    private let manager = CLLocationManager()
    
    // Location and heading use a reference count to track whether
    // they are needed.
    
    private var locationDependents: Int = 0 {
        willSet {
            if newValue > 0 && locationDependents <= 0 {
                log.info("Starting location updates")
                manager.startUpdatingLocation()
            } else if newValue <= 0 && locationDependents > 0 {
                log.info("Stopping location updates")
                manager.stopUpdatingLocation()
            }
        }
    }
    private var headingDependents: Int = 0 {
        willSet {
            #if !os(macOS)
            if newValue > 0 && headingDependents <= 0 {
                log.info("Starting heading updates")
                manager.startUpdatingHeading()
            } else if newValue <= 0 && headingDependents > 0 {
                log.info("Stopping heading updates")
                manager.stopUpdatingHeading()
            }
            #endif
        }
    }
    
    override init() {
        super.init()
        if !CLLocationManager.locationServicesEnabled() {
            log.warning("No location services enabled!")
        }
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        clLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        clHeading = newHeading
    }
    
    func dependOnLocation() {
        locationDependents += 1
    }
    
    func dependOnHeading() {
        headingDependents += 1
    }
    
    func undependOnLocation() {
        locationDependents -= 1
    }
    
    func undependOnHeading() {
        headingDependents -= 1
    }
}
