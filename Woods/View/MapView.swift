//
//  MapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

public struct MapView: UIViewRepresentable {
    private var locationManager = CLLocationManager()
    
    public func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    public func makeUIView(context: Context) -> MKMapView {
        setupLocationManager()
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    public func updateUIView(_ uiView: MKMapView, context: Context) {}
}
