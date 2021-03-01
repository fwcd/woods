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
    @Binding var region: MKCoordinateRegion?
    
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
        Coordinator(region: $region)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupLocationManager(coordinator: context.coordinator)
        let mapView = MKMapView()
        mapView.addAnnotations(annotations)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        @Binding private var region: MKCoordinateRegion?
        
        init(region: Binding<MKCoordinateRegion?>) {
            _region = region
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            region = mapView.region
        }
        
        // TODO: Customize annotations
    }
}
