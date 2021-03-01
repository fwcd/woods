//
//  GeocacheMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit

struct GeocacheMapView: View {
    let geocaches: [Geocache]
    
    var body: some View {
        Map(annotations: geocaches.map { cache -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = cache.location.usingCoreLocation
            return annotation
        })
        .edgesIgnoringSafeArea(.all)
    }
}

struct GeocacheMapView_Previews: PreviewProvider {
    static var previews: some View {
        GeocacheMapView(geocaches: [])
    }
}
