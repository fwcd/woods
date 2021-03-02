//
//  RichGeocacheMapView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct RichGeocacheMapView: View {
    @EnvironmentObject private var geocaches: Geocaches
    @State private var selectedGeocacheId: String? = nil
    @State private var region: MKCoordinateRegion? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeocacheMapView(geocaches: geocaches.geocaches, selectedGeocacheId: $selectedGeocacheId, region: $region)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                if let region = region {
                    geocaches.refresh(with: query(from: region))
                }
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.primary)
            }
            .padding(10)
            SlideOverCard {
                VStack {
                    Text("Selected: \(String(describing: selectedGeocacheId))")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func query(from region: MKCoordinateRegion) -> GeocachesInRadiusQuery {
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
        return query
    }
}

struct RefreshableGeocacheMapView_Previews: PreviewProvider {
    @StateObject static var geocaches = Geocaches(accounts: Accounts(testMode: true))
    static var previews: some View {
        RichGeocacheMapView()
            .environmentObject(geocaches)
    }
}
