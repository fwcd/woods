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
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        Map(annotations: geocaches.map { cache in
            Map.Annotation(
                coordinate: cache.location.asCLCoordinate,
                title: cache.name,
                color: color(for: cache.type)
            )
        }, region: $region)
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
    @State static var region: MKCoordinateRegion? = nil
    static var previews: some View {
        GeocacheMapView(geocaches: [], region: $region)
    }
}
