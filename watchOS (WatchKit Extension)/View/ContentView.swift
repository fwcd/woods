//
//  ContentView.swift
//  WatchWoods WatchKit Extension
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // TODO: Display a navigator in sync with the iOS app?
        NavigationView {
            WaypointLocatingNavigatorView(target: Coordinates())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    
    static var previews: some View {
        ContentView()
            .environmentObject(locationManager)
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
