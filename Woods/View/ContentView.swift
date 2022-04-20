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
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                }
            WaypointListsView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Lists")
                    }
                }
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            AccountsView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle.fill")
                        Text("Accounts")
                    }
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
    }
}
