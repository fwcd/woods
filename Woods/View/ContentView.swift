//
//  ContentView.swift
//  Woods
//
//  Created by Fredrik on 6/21/20.
//  Copyright © 2020 Fredrik.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RichMapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            LocationView()
                .tabItem {
                    Label("Location", systemImage: "location.fill")
                }
            WaypointListsView()
                .tabItem {
                    Label("Lists", systemImage: "list.bullet")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            AccountsView()
                .tabItem {
                    Label("Accounts", systemImage: "person.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var accounts = Accounts(testMode: true)
    @StateObject static var waypoints = Waypoints(accounts: accounts)
    @StateObject static var locationManager = LocationManager()
    static var previews: some View {
        ContentView()
            .environmentObject(accounts)
            .environmentObject(waypoints)
            .environmentObject(locationManager)
            .previewInterfaceOrientation(.portrait)
    }
}
