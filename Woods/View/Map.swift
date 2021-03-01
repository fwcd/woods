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

struct Map: UIViewRepresentable {
    let annotations: [MKPointAnnotation]
    @Binding var location: CLLocation?
    
    let locationManager = CLLocationManager()
    
    func setupLocationManager(coordinator: Coordinator) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = coordinator
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(location: $location)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupLocationManager(coordinator: context.coordinator)
        let mapView = MKMapView()
        mapView.addAnnotations(annotations)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        @Binding private var location: CLLocation?
        
        init(location: Binding<CLLocation?>) {
            _location = location
        }
    }
}
