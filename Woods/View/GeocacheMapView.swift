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
    @EnvironmentObject private var geocaches: Geocaches
    @State private var location: CLLocation?
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(annotations: geocaches.geocaches.map { cache -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = cache.location.asCLCoordinate
                return annotation
            }, location: $location)
            .edgesIgnoringSafeArea(.all)
            Button(action: {
                if let location = location {
                    geocaches.refresh(with: GeocachesInRadiusQuery(center: Coordinates(from: location.coordinate), radius: Length(meters: 10_000)))
                }
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 40))
            }
            .padding(10)
        }
    }
}

struct GeocacheMapView_Previews: PreviewProvider {
    @StateObject static var geocaches = Geocaches(accounts: Accounts(testMode: true))
    static var previews: some View {
        GeocacheMapView()
            .environmentObject(geocaches)
    }
}
