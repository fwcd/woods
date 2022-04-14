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
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selection: $selection, region: $region)
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
        mapView.userTrackingMode = .follow
        mapView.delegate = context.coordinator
        mapView.mapType = useSatelliteView ? .hybrid : .standard
        
        #if canImport(UIKit)
        // Workaround for slow map annotation selection
        // See https://stackoverflow.com/questions/35639388/tapping-an-mkannotation-to-select-it-is-really-slow
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(tapRecognizer)
        #endif
        
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
        
        #if canImport(UIKit)
        // Workaround for slow map annotation selection
        // See https://stackoverflow.com/questions/35639388/tapping-an-mkannotation-to-select-it-is-really-slow
        
        @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            guard let view = sender?.view as? MKMapView else { return }
            view.isZoomEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                view.isZoomEnabled = true
            }
        }
        #endif
    }
    
    init(
        annotations: [Annotation] = [],
        selection: Binding<T?>? = nil,
        region: Binding<MKCoordinateRegion?>? = nil,
        userTrackingMode: Binding<MKUserTrackingMode>? = nil,
        useSatelliteView: Binding<Bool>? = nil
    ) {
        self.annotations = annotations
        _selection = selection ?? .constant(nil)
        _region = region ?? .constant(nil)
        _userTrackingMode = userTrackingMode ?? .constant(.none)
        _useSatelliteView = useSatelliteView ?? .constant(false)
    }
}
