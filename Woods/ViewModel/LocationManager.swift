//
//  LocationManager.swift
//  Woods
//
//  Created by Fredrik on 3/2/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import Combine
import CoreLocation
import OSLog

private let log = Logger(subsystem: "Woods", category: "LocationManager")

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var location: CLLocation? = nil
    @Published private(set) var heading: CLHeading? = nil
    private let manager = CLLocationManager()
    
    var updatingLocation: Bool = false {
        didSet {
            if updatingLocation {
                manager.startUpdatingLocation()
            } else {
                manager.stopUpdatingLocation()
            }
        }
    }
    var updatingHeading: Bool = false {
        didSet {
            if updatingHeading {
                manager.startUpdatingHeading()
            } else {
                manager.stopUpdatingHeading()
            }
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
        location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
}
