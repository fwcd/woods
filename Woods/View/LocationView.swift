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
            Text("\(locationManager.location?.description ?? "No Location")")
                .textSelection(.enabled)
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
