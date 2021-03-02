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
    @State private var useSatelliteView: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeocacheMapView(geocaches: geocaches.geocaches.values.sorted { $0.id < $1.id }, selectedGeocacheId: $selectedGeocacheId, region: $region, useSatelliteView: $useSatelliteView)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                Button(action: {
                    if let region = region {
                        geocaches.refresh(with: query(from: region))
                    }
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                Button(action: {
                    useSatelliteView = !useSatelliteView
                }) {
                    Image(systemName: "building.2.crop.circle.fill")
                }
            }
            .foregroundColor(.primary)
            .font(.system(size: 40))
            .padding(10)
            SlideOverCard {
                VStack {
                    if let id = selectedGeocacheId, let geocache = geocaches[id] {
                        GeocacheDetailView(geocache: geocache)
                    } else {
                        SearchBar(placeholder: "Search for Geocaches...", text: $searchText)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
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
