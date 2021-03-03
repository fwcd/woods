//
//  WaypointNavigatorView.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik. All rights reserved.
//

import SwiftUI

struct WaypointNavigatorView: View {
    let target: Coordinates
    
    @EnvironmentObject private var locationManager: LocationManager
    
//    private var distance: Length? {
//        locationManager.location.map { target.distance(to: Coordinates(from: $0.coordinate)) }
//    }
    private var distance: Length? { Length(10, .kilometers) }
    
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: "location.north.fill")
                .font(.system(size: 128))
            VStack {
                if let distance = distance {
                    Text(distance.description)
                        .font(.title)
                    Text("+- accuracy")
                        .font(.title2)
                }
            }
        }
    }
}

struct WaypointNavigatorView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        WaypointNavigatorView(target: mockGeocaches().first!.location)
            .environmentObject(locationManager)
    }
}
