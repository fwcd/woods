//
//  RefreshableGeocacheMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct RefreshableGeocacheMapView: View {
    @EnvironmentObject private var geocaches: Geocaches
    @State private var region: MKCoordinateRegion? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeocacheMapView(geocaches: geocaches.geocaches, region: $region)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                if let region = region {
                    let center = region.center
                    let span = region.span
                    let topLeft = CLLocation(
                        latitude: center.latitude - (span.latitudeDelta / 2),
                        longitude: center.longitude - (span.longitudeDelta / 2)
                    )
                    let bottomRight = CLLocation(
                        latitude: center.latitude + (span.latitudeDelta / 2),
                        longitude: center.longitude + (span.longitudeDelta / 2)
                    )
                    let diameter = topLeft.distance(from: bottomRight).magnitude
                    let query = GeocachesInRadiusQuery(
                        center: Coordinates(from: center),
                        radius: Length(meters: diameter / 2)
                    )
                    geocaches.refresh(with: query)
                }
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.primary)
            }
            .padding(10)
        }
    }
}

struct RefreshableGeocacheMapView_Previews: PreviewProvider {
    @StateObject static var geocaches = Geocaches(accounts: Accounts(testMode: true))
    static var previews: some View {
        RefreshableGeocacheMapView()
            .environmentObject(geocaches)
    }
}
