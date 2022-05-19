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
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 10) {
                    Text("\(locationManager.location?.description ?? "No Location")")
                        .font(.title2)
                    if let accuracy = locationManager.locationAccuracy {
                        Text("\u{00B1} \(accuracy.description)")
                            .font(.title3)
                    }
                }
                VStack(spacing: 10) {
                    Text(locationManager.heading.map { String("\($0)°") } ?? "No Heading")
                        .font(.title2)
                    if let accuracy = locationManager.headingAccuracy {
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
