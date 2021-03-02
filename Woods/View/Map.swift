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

/// A map with custom annotations.
struct Map<T>: UIViewRepresentable where T: Hashable {
    let annotations: [Annotation]
    @Binding var selection: T?
    @Binding var region: MKCoordinateRegion?
    @Binding var useSatelliteView: Bool
    
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
        Coordinator(selection: $selection, region: $region)
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
        let current = Dictionary(uniqueKeysWithValues: mapView.annotations.compactMap { $0 as? Annotation }.map { ($0.tag, $0) })
        let new = Dictionary(uniqueKeysWithValues: annotations.map { ($0.tag, $0) })
        let toBeRemoved = Set(current.keys).subtracting(new.keys).compactMap { current[$0] }
        let toBeAdded = Set(new.keys).subtracting(current.keys).compactMap { new[$0] }
        mapView.removeAnnotations(toBeRemoved)
        mapView.addAnnotations(toBeAdded)
    }
    
    class Annotation: NSObject, MKAnnotation {
        let tag: T
        let coordinate: CLLocationCoordinate2D
        let title: String?
        let subtitle: String?
        let color: Color?
        let iconName: String?
        
        init(tag: T, coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, color: Color? = nil, iconName: String? = nil) {
            self.tag = tag
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.color = color
            self.iconName = iconName
        }
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        @Binding private var selection: T?
        @Binding private var region: MKCoordinateRegion?
        
        init(selection: Binding<T?>, region: Binding<MKCoordinateRegion?>) {
            _selection = selection
            _region = region
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            region = mapView.region
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? Annotation,
                  let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(MKMarkerAnnotationView.self)) as? MKMarkerAnnotationView else { return nil }
            
            annotationView.annotation = annotation
            
            if let color = annotation.color {
                annotationView.markerTintColor = UIColor(color)
            }
            
            if let iconName = annotation.iconName {
                annotationView.glyphImage = UIImage(systemName: iconName)
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            selection = (view.annotation as? Annotation)?.tag
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            selection = nil
        }
    }
    
    init(annotations: [Annotation], selection: Binding<T?>? = nil, region: Binding<MKCoordinateRegion?>? = nil, useSatelliteView: Binding<Bool>? = nil) {
        self.annotations = annotations
        _selection = selection ?? .constant(nil)
        _region = region ?? .constant(nil)
        _useSatelliteView = useSatelliteView ?? .constant(false)
    }
}
