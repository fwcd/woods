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
            VStack(spacing: 10) {
                Text("\(locationManager.location?.description ?? "No Location")")
                    .font(.title2)
                    .textSelection(.enabled)
                if let accuracy = locationManager.accuracy {
                    Text("\u{00B1} \(accuracy.description)")
                        .textSelection(.enabled)
                        .font(.title3)
                }
            }
            .navigationTitle("Location")
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
