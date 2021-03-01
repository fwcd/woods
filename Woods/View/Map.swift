//
//  MapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import CoreLocation
import SwiftUI
import UIKit
import MapKit

struct Map: UIViewRepresentable {
    let annotations: [Annotation]
    @Binding var region: MKCoordinateRegion?
    
    private let locationManager = CLLocationManager()
    
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
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(MKMarkerAnnotationView.self))
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
    
    class Annotation: NSObject, MKAnnotation {
        let coordinate: CLLocationCoordinate2D
        let title: String?
        let subtitle: String?
        let color: Color?
        
        init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, color: Color? = nil) {
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.color = color
        }
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        @Binding private var region: MKCoordinateRegion?
        
        init(region: Binding<MKCoordinateRegion?>) {
            _region = region
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            region = mapView.region
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? Annotation,
                  let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(MKMarkerAnnotationView.self)) as? MKMarkerAnnotationView else { return nil }
            
            annotationView.annotation = annotation
            annotationView.markerTintColor = UIColor(annotation.color ?? .red)
            
            return annotationView
        }
    }
    
    init(annotations: [Annotation], region: Binding<MKCoordinateRegion?>) {
        self.annotations = annotations
        _region = region
    }
}
