//
//  GeocacheMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct GeocacheMapView: View {
    let geocaches: [Geocache]
    @Binding var selectedGeocacheId: String?
    @Binding var region: MKCoordinateRegion?
    @Binding var useSatelliteView: Bool
    
    var body: some View {
        Map(annotations: geocaches.map { cache in
            Map.Annotation(
                tag: cache.id,
                coordinate: cache.location.asCLCoordinate,
                title: cache.name,
                color: color(for: cache.type),
                iconName: "archivebox.fill"
            )
        }, selection: $selectedGeocacheId, region: $region, useSatelliteView: $useSatelliteView)
    }
    
    init(
        geocaches: [Geocache],
        selectedGeocacheId: Binding<String?>? = nil,
        region: Binding<MKCoordinateRegion?>? = nil,
        useSatelliteView: Binding<Bool>? = nil
    ) {
        self.geocaches = geocaches
        _selectedGeocacheId = selectedGeocacheId ?? .constant(nil)
        _region = region ?? .constant(nil)
        _useSatelliteView = useSatelliteView ?? .constant(false)
    }
    
    private func color(for cacheType: GeocacheType) -> Color {
        switch cacheType {
        case .traditional:
            return .green
        case .multi:
            return .orange
        case .mystery:
            return .blue
        case .virtual:
            return .white
        case .webcam:
            return .gray
        case .earth:
            return .yellow
        case .letterbox:
            return .blue
        case .wherigo:
            return .blue
        case .event:
            return .red
        case .megaEvent:
            return .red
        default:
            return .black
        }
    }
}

struct GeocacheMapView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheMapView(geocaches: [])
    }
}
