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
        Map(annotations: geocaches.map { cache -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = cache.name
            annotation.coordinate = cache.location.asCLCoordinate
            return annotation
        }, region: $region)
    }
}

struct GeocacheMapView_Previews: PreviewProvider {
    @State static var region: MKCoordinateRegion? = nil
    static var previews: some View {
        GeocacheMapView(geocaches: [], region: $region)
    }
}
