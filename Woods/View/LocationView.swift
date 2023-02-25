//
//  LocationView.swift
//  Woods
//
//  Created by Fredrik on 19.05.22.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                CompassRoseView(heading: locationManager.heading ?? .zero)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(30)
                VStack(spacing: 10) {
                    Text("\(locationManager.location?.description ?? "No Location")")
                        .font(.title2)
                    if let accuracy = locationManager.locationAccuracy {
                        Text("\u{00B1} \(accuracy.description)")
                            .font(.title3)
                    }
                }
                VStack(spacing: 10) {
                    Text(locationManager.altitude.map { String("\($0) Altitude") } ?? "No Altitude")
                        .font(.title2)
                    if let accuracy = locationManager.altitudeAccuracy {
                        Text("\u{00B1} \(accuracy.description)")
                            .font(.title3)
                    }
                }
            }
            .navigationTitle("Location")
            .textSelection(.enabled)
            .onAppear {
                locationManager.dependOnLocation()
                locationManager.dependOnHeading()
            }
            .onDisappear {
                locationManager.undependOnLocation()
                locationManager.undependOnHeading()
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        LocationView()
            .environmentObject(locationManager)
    }
}
