//
//  MapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import CoreLocation
import SwiftUI
import MapKit

/// A map with custom annotations.
struct Map<T>: UIOrNSViewRepresentable where T: Hashable {
    let annotations: [Annotation]
    @Binding var selection: T?
    @Binding var region: MKCoordinateRegion?
    @Binding var userTrackingMode: MKUserTrackingMode
    @Binding var useSatelliteView: Bool
    let zoomToAnnotations: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selection: $selection, region: $region, userTrackingMode: $userTrackingMode)
    }
    
    #if canImport(UIKit)
    func makeUIView(context: Context) -> MKMapView { makeView(context: context) }
    
    func updateUIView(_ mapView: MKMapView, context: Context) { updateView(mapView, context: context) }
    #endif
    
    #if canImport(AppKit)
    func makeNSView(context: Context) -> MKMapView { makeView(context: context) }
    
    func updateNSView(_ mapView: MKMapView, context: Context) { updateView(mapView, context: context) }
    #endif
    
    func makeView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(MKMarkerAnnotationView.self))
        mapView.addAnnotations(annotations)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = userTrackingMode
        mapView.delegate = context.coordinator
        mapView.mapType = useSatelliteView ? .hybrid : .standard
        return mapView
    }
    
    func updateView(_ mapView: MKMapView, context: Context) {
        mapView.userTrackingMode = userTrackingMode
        mapView.mapType = useSatelliteView ? .hybrid : .standard
        mapView.selectedAnnotations = selection.flatMap { tag in
            mapView.annotations.first { ($0 as? Annotation)?.tag == tag }
        }.map { [$0] } ?? []
        
        // Update annotations
        let current = Dictionary(uniqueKeysWithValues: mapView.annotations.compactMap { $0 as? Annotation }.map { ($0.tag, $0) })
        let new = Dictionary(uniqueKeysWithValues: annotations.map { ($0.tag, $0) })
        let toBeRemoved = Set(current.keys).subtracting(new.keys).compactMap { current[$0] }
        let toBeAdded = Set(new.keys).subtracting(current.keys).compactMap { new[$0] }
        mapView.removeAnnotations(toBeRemoved)
        mapView.addAnnotations(toBeAdded)
        if zoomToAnnotations {
            mapView.showAnnotations(annotations, animated: true)
        }
    }
    
    class Annotation: NSObject, MKAnnotation {
        let tag: T
        let coordinate: CLLocationCoordinate2D
        let title: String?
        let subtitle: String?
        let color: Color?
        let iconName: String?
        let required: Bool
        
        init(tag: T, coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, color: Color? = nil, iconName: String? = nil, required: Bool = true) {
            self.tag = tag
            self.coordinate = coordinate
            self.title = title
            self.subtitle = subtitle
            self.color = color
            self.iconName = iconName
            self.required = required
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding private var selection: T?
        @Binding private var region: MKCoordinateRegion?
        @Binding private var userTrackingMode: MKUserTrackingMode
        
        init(selection: Binding<T?>, region: Binding<MKCoordinateRegion?>, userTrackingMode: Binding<MKUserTrackingMode>) {
            _selection = selection
            _region = region
            _userTrackingMode = userTrackingMode
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            region = mapView.region
        }
        
        func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
            userTrackingMode = mode
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? Annotation,
                  let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(MKMarkerAnnotationView.self)) as? MKMarkerAnnotationView else { return nil }
            
            annotationView.annotation = annotation
            
            if let color = annotation.color {
                annotationView.markerTintColor = UIOrNSColor(color)
            }
            
            if let iconName = annotation.iconName {
                annotationView.glyphImage = UIOrNSImage(systemName: iconName)
            }
            
            if annotation.required {
                annotationView.displayPriority = .required
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
    
    init(
        annotations: [Annotation] = [],
        selection: Binding<T?>? = nil,
        region: Binding<MKCoordinateRegion?>? = nil,
        userTrackingMode: Binding<MKUserTrackingMode>? = nil,
        useSatelliteView: Binding<Bool>? = nil,
        zoomToAnnotations: Bool = false
    ) {
        self.annotations = annotations
        _selection = selection ?? .constant(nil)
        _region = region ?? .constant(nil)
        _userTrackingMode = userTrackingMode ?? .constant(.none)
        _useSatelliteView = useSatelliteView ?? .constant(false)
        self.zoomToAnnotations = zoomToAnnotations
    }
}
