//
//  ContentView.swift
//  WatchWoods WatchKit Extension
//
//  Created by Fredrik on 18.11.21.
//  Copyright © 2021 Fredrik.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var remoteHostManager: RemoteHostManager
    
    var body: some View {
        NavigationView {
            if let target = remoteHostManager.navigationTarget {
                WaypointLocatingNavigatorView(target: target)
            } else {
                Text("Start navigating on the host to view the navigator!")
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var locationManager = LocationManager()
    @StateObject static var remoteHostManager = RemoteHostManager()
    
    static var previews: some View {
        ContentView()
            .environmentObject(locationManager)
            .environmentObject(remoteHostManager)
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
